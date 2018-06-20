# frozen_string_literal: true

class GitHubEvent
  PURCHASE = "marketplace_purchase"
  INSTALLATION = "installation"

  def initialize(type:, body:)
    @body = body
    @type = type
  end

  def process
    case type
    when PURCHASE
      update_purchase
    when INSTALLATION
      create_install
    else
      Rails.logger.info("Received GitHub event -- #{type}")
    end
  end

  private

  attr_reader :body, :type

  def create_install
    # create install record to keep track
  end

  def update_purchase
    action = body.fetch("action")
    owner = upsert_owner

    case action
    when "purchased", "changed"
      owner.update!(
        marketplace_plan_id: body["marketplace_purchase"]["plan"]["id"],
      )
    when "cancelled"
      owner.update!(marketplace_plan_id: nil)
    else
      raise "Unknown GitHub Marketplace action (#{action})"
    end
  end

  def upsert_owner
    Owner.upsert(
      github_id: body["marketplace_purchase"]["account"]["id"],
      name: body["marketplace_purchase"]["account"]["login"],
      organization: organization_event?(body),
    )
  end

  def organization_event?
    account_type = body["marketplace_purchase"]["account"]["type"]
    account_type == GitHubApi::ORGANIZATION_TYPE
  end
end
