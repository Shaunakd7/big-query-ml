SELECT
  contributors,
  metric_test,
  metric_control,
  difference,
  relative_difference,
  unexpected_difference,
  relative_unexpected_difference,
  apriori_support
FROM
  ML.GET_INSIGHTS(
    MODEL `common-tech-434709.sandbox.user_count_contribution_model_mar25_dec24_by_user_attrs_debit_txn`
  )
ORDER BY
  unexpected_difference DESC; -- Sort by unexpected change to find key user segments driving the change