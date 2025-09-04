CREATE OR REPLACE TABLE `common-tech-434709.sandbox.user_count_mar25_dec24_by_user_attrs_debit_txn` AS -- Same table name, but new data structure
(
  SELECT
    -- Dimensions from events table
    T1.app,
    T1.channel,
    T1.event_source,

    -- Dimensions from user_base_fact table (REDUCED CURATED LIST)
    T2.acq_channel_l1,
    T2.current_tier,
    T2.gender,
    T2.ever_active_debit_card,
    T2.is_referred,

    COUNT(DISTINCT T1.user_id) AS total_unique_users,
    FALSE AS is_test
  FROM
    `common-tech-434709.events.events` AS T1
  LEFT JOIN
    `common-tech-434709.datamart.user_base_fact` AS T2
    ON T1.user_id = T2.actor_id
  WHERE
    EXTRACT(YEAR FROM T1.original_timestamp) = 2024 AND EXTRACT(MONTH FROM T1.original_timestamp) = 12
    AND T1.date = DATE('2024-12-01')
    AND T1.user_id IS NOT NULL
    AND T1.event = 'DebitTransaction'
  GROUP BY
    T1.app, T1.channel, T1.event_source,
    T2.acq_channel_l1, T2.current_tier, T2.gender, T2.ever_active_debit_card, T2.is_referred
)
UNION ALL
(
  SELECT
    -- Dimensions from events table
    T1.app,
    T1.channel,
    T1.event_source,

    -- Dimensions from user_base_fact table (REDUCED CURATED LIST)
    T2.acq_channel_l1,
    T2.current_tier,
    T2.gender,
    T2.ever_active_debit_card,
    T2.is_referred,

    COUNT(DISTINCT T1.user_id) AS total_unique_users,
    TRUE AS is_test
  FROM
    `common-tech-434709.events.events` AS T1
  LEFT JOIN
    `common-tech-434709.datamart.user_base_fact` AS T2
    ON T1.user_id = T2.actor_id
  WHERE
    EXTRACT(YEAR FROM T1.original_timestamp) = 2025 AND EXTRACT(MONTH FROM T1.original_timestamp) = 3
    AND T1.date = DATE('2025-03-01')
    AND T1.user_id IS NOT NULL
    AND T1.event = 'DebitTransaction'
  GROUP BY
    T1.app, T1.channel, T1.event_source,
    T2.acq_channel_l1, T2.current_tier, T2.gender, T2.ever_active_debit_card, T2.is_referred
);