module SystemFixtures::Roles
  SEEDED_ORDERED_ROLES  = ['super user', 'system admin', 'dealer admin', 'corporate admin', 'brand admin', 'merchant admin']
  SEED_SPECIFICATIONS   = (1..SEEDED_ORDERED_ROLES.length).zip(SEEDED_ORDERED_ROLES)

  def seeded?(role); role.id < 7; end
  def seed; create_seeds :roles, SEED_SPECIFICATIONS; end
  
  def create_super_user;      create_with(1, SEEDED_ORDERED_ROLES,       'Admin')     ; end
  def create_system_admin;    create_with(2, SEEDED_ORDERED_ROLES[1..5], 'Admin')     ; end
  def create_dealer_admin;    create_with(3, SEEDED_ORDERED_ROLES[2..5], 'Dealer')    ; end
  def create_corporate_admin; create_with(4, SEEDED_ORDERED_ROLES[3..5], 'Corporate') ; end
  def create_brand_admin;     create_with(5, ['Merchant'], 'Brand')                   ; end
  def create_merchant_admin;  create_with(6, ['Merchant'], 'Merchant')                ; end
  
  def create_with(id, other_roles, domain_type)
    role = create_with_id(:role, id, SEED_SPECIFICATIONS.assoc(id)[1])
    role.can_manage_roles = other_roles
    role.domain_type = domain_type
    role.save
    role
  end
  
  def super_user_permissions
    @@permissions = Ability.create_permissions_hash # %w(loyalty_id)
    select_gm_application_role
    select_oo_role
    select_egift_permissions :admin, %w(salespageoption giftcards emailcampaign systemvariables sitecontent iprestriction search)
    remove %w(opt_in_opt_out_opt_in)
  end
  def system_admin_permissions
    @@permissions = Ability.create_permissions_hash %w(product_configurations roles_and_permissions marketing_campaign_templates ps_marketing loyalty_id)
    select_gm_application_role
    select_oo_role
    select_egift_permissions :staff, %w(salespageoption giftcards emailcampaign systemvariables sitecontent iprestriction search)
    remove %w(opt_in_opt_out_opt_in)
  end
  def dealer_admin_permissions
    @@permissions = Ability.create_permissions_hash(
                  %w(reservation_book shoutout marketing_campaigns restaurant_exception_days restaurant_messaging_and_notifications social_media_posts email sms landing_pages loyalty_id),
                  %w(product_configurations roles_and_permissions marketing_campaign_templates ps_marketing store_id branch_zoura brand_zoura corporate_zoura offers_and_incentives))
    remove %w(email_limit sms_send opt_in_opt_out_opt_in transactional_templates administrative_settings_update)
    remove %w(transactional_templates_updatemerchant transactional_templates_view marketing_campaign_templates_view marketing_campaign_templates_update)
    select_gm_application_role nil
    select_oo_role
    select_egift_permissions :staff, []
  end
  
  def corporate_admin_permissions
    msa_permissions %w(corporate_portal_create brand_portal_create)
    select_gm_application_role
    select_oo_role
    select_view_only_loyalty_id
  end
  def brand_admin_permissions
    msa_permissions %w(corporate brand_portal_create brand_portal_update)
    select_gm_application_role
    select_oo_role
    select_view_only_loyalty_id
  end
  def merchant_admin_permissions
    msa_permissions %w(restaurant_dashboard corporate brand)
    select_gm_application_role
    select_oo_role :reportmanager
    select_view_only_loyalty_id
    remove %w(report_manager_user_rights_consoleuser report_manager_user_rights_voidorder report_manager_user_rights_transferorder pos_api_key_generate)
  end
  def msa_permissions(exclude_abilities)
    no_abilities = exclude_abilities + %w(product_types product_configurations roles_and_permissions marketing_campaign_templates ps_marketing dealer_user_management store_id branch_zoura brand_zoura corporate_zoura transactional_templates administrative_settings_update loyalty_id)
    @@permissions = Ability.create_permissions_hash([], no_abilities)
    select_egift_permissions :merchant, []
  end
  
  def select_view_only_loyalty_id(role = :storeadmin)
    select :loyalty_id, %w(create update delete), role
  end
  def select_gm_application_role(role = :storeadmin)
    select :gm_application_roles, %w(applicationadmin storeadmin brandadmin host), role
  end
  def select_oo_role(role = :merchantmanager)
    select :oo_roles, %w(merchantmanager reportmanager callcenteremployee), role
    remove [:report_manager_user_rights_mercurypaymentsedit] if role == :merchantmanager
  end
  def select_egift_permissions(role = :staff, rights = %w(salespageoption giftcards emailcampaign systemvariables sitecontent iprestriction))
    select :egift_roles, %w(admin staff merchant), role
    select :egift_rights, %w(salespageoption giftcards emailcampaign systemvariables sitecontent iprestriction paymentconfiguration newmerchant reports search), rights
  end
  def select(category, options, selected)
    selected = [selected.to_s] unless selected.kind_of?(Array)
    remove((options - selected).collect{|permission_option| "#{category}_#{permission_option}"})
  end
  
  def remove(permissions); permissions.each{|permission| @@permissions.delete(permission.to_s)}; @@permissions; end
end
