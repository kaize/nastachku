module Web::Admin::ApplicationHelper
  def url_to_payment(order)
    case order.payment_system
    when "platidoma"
      "#{configus.platidoma.transaction_view_host}/payments/cur_month/?act=show_trans&trans_id=#{order.transaction_id}"
    when "payanyway"
      "#{configus.payanyway.transaction_view_host}/operationInfoDetails.htm?operationId=#{order.transaction_id}"
    end
  end
end
