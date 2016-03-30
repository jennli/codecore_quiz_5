class AuctionDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def title
    object.title.titleize
  end

  def price
    # `helpers` (aka `h`)
    h.number_to_currency object.price
  end

  def end_date
    object.end_date.strftime("%m-%d-%Y")
  end

  def state_label
    bootstrap_classes = {"published" => "label label-success", "draft" => "label label-default", "reserve_met" => "label label-success", "won" => "label label-success", "canceled" => "label label-warning", "reserve_not_met" => "label label-default"}
    h.content_tag :div, class:"#{bootstrap_classes[object.aasm_state]}" do
      object.aasm_state
    end
  end

  def publish_button

    if object.draft?
      h.link_to "publish",
      h.auction_publishings_path(object), method: :post, class: "btn btn-primary btn-xs", data: {confirm: "are you sure? you won't be able to edit a campaign after it's pubhlished"}
    end

  end


end
