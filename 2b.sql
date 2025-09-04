CREATE OR REPLACE MODEL `common-tech-434709.sandbox.debit_txn_freq_per_user_contribution_model_mar25_dec24_by_user_attrs`
  OPTIONS(
    model_type = 'CONTRIBUTION_ANALYSIS',
    contribution_metric = 'sum(total_debit_transactions)/sum(total_unique_users_with_txn)', -- DEFINING THE RATIO HERE
    dimension_id_cols = [
      'app', 'channel', 'event_source',
      'acq_channel_l1', 'current_tier', 'gender', 'ever_active_debit_card', 'is_referred'
    ],
    is_test_col = 'is_test',
    min_apriori_support = 0.01
  ) AS
SELECT * FROM `common-tech-434709.sandbox.debit_txn_freq_per_user_mar25_dec24_by_user_attrs`;