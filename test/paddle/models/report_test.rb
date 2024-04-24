require "test_helper"

class ReportTest < Minitest::Test

  def test_report_list
    reports = Paddle::Report.list

    assert_equal Paddle::Collection, reports.class
    assert_equal Paddle::Report, reports.data.first.class
    assert_equal "rep_01hw8a1mg788ffxetyzs77vk3n", reports.data.first.id
  end

  def test_report_retrieve
    report = Paddle::Report.retrieve(id: "rep_01hw8a1mg788ffxetyzs77vk3n")

    assert_equal Paddle::Report, report.class
    assert_equal "rep_01hw8a1mg788ffxetyzs77vk3n", report.id
    assert_equal "transactions", report.type
  end

  def test_report_csv
    csv = Paddle::Report.csv(id: "rep_01hw8a1mg788ffxetyzs77vk3n")

    assert_match (/sandbox-reports/), csv
  end

  def test_report_create
    report = Paddle::Report.create(
      type: "transactions",
      filters: [
        {name: "updated_at", operator: "lt", value: "2024-04-30"},
        {name: "updated_at", operator: "gte", value: "2024-04-01"}
      ]
    )

    assert_equal Paddle::Report, report.class
    assert_equal "transactions", report.type
  end

end
