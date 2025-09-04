CREATE OR REPLACE MODEL `common-tech-434709.sandbox.user_count_contribution_model_mar25_dec24_by_user_attrs_debit_txn`
  OPTIONS(
    model_type = 'CONTRIBUTION_ANALYSIS',
    contribution_metric = 'sum(total_unique_users)',
    dimension_id_cols = [
      'app', 'channel', 'event_source',
      'acq_channel_l1', 'current_tier', 'gender', 'ever_active_debit_card', 'is_referred' -- REDUCED SET OF DIMENSIONS
    ],
    is_test_col = 'is_test',
    min_apriori_support = 0.01
  ) AS
SELECT * FROM `common-tech-434709.sandbox.user_count_mar25_dec24_by_user_attrs_debit_txn`;