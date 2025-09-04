CREATE OR REPLACE TABLE `common-tech-434709.sandbox.debit_txn_freq_per_user_mar25_dec24_by_user_attrs` AS -- NEW TABLE NAME
(
  SELECT
    -- Dimensions
    T1.app, T1.channel, T1.event_source,
    T2.acq_channel_l1, T2.current_tier, T2.gender, T2.ever_active_debit_card, T2.is_referred,

    -- Metrics for Ratio
    COUNT(T1.event_id) AS total_debit_transactions,               -- Numerator: Total DebitTransaction events
    COUNT(DISTINCT T1.user_id) AS total_unique_users_with_txn,     -- Denominator: Total unique users with DebitTransaction

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
    AND T1.event = 'DebitTransaction' -- Filtering for DebitTransaction events
  GROUP BY
    T1.app, T1.channel, T1.event_source,
    T2.acq_channel_l1, T2.current_tier, T2.gender, T2.ever_active_debit_card, T2.is_referred
)
UNION ALL
(
  SELECT
    -- Dimensions
    T1.app, T1.channel, T1.event_source,
    T2.acq_channel_l1, T2.current_tier, T2.gender, T2.ever_active_debit_card, T2.is_referred,

    -- Metrics for Ratio
    COUNT(T1.event_id) AS total_debit_transactions,
    COUNT(DISTINCT T1.user_id) AS total_unique_users_with_txn,

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