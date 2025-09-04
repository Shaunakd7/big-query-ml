SELECT
  contributors,
  metric_test,
  metric_control,
  (metric_test - metric_control) AS calculated_difference, -- <<< This is where 'difference' is calculated
  SAFE_DIVIDE((metric_test - metric_control), metric_control) AS calculated_relative_difference, -- <<< This is where 'relative_difference' is calculated
  apriori_support
FROM ML.GET_INSIGHTS(
    MODEL `common-tech-434709.sandbox.debit_txn_freq_per_user_contribution_model_mar25_dec24_by_user_attrs`
  )
ORDER BY
  calculated_difference DESC;