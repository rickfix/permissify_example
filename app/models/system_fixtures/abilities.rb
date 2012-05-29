module SystemFixtures::Abilities
  def seed
    { 'Marketing Campaign Templates'            => 'PS Admin Portal',
      'Product Configurations'                  => 'PS Admin Portal',
      'PS Marketings'                           => 'PS Admin Portal',
      'Roles and Permissions'                   => 'PS Admin Portal',
      'Dealer User Management'                  => 'PS Admin Portal',
      'Information and Contact'                 => 'Branch and Location Portals : Settings',
      'Branch User Management'                  => 'Branch and Location Portals : Settings',
      'Product Types'                           => 'Branch and Location Portals : Settings',
      'Marketing Campaigns'                     => 'Branch and Location Portals : Marketing Engine',
      'Landing Pages'                           => 'Branch and Location Portals : Marketing Engine',
      'Offers and Incentives'                   => 'Branch and Location Portals : Marketing Engine',
      'Loyalty ID'                              => 'Branch and Location Portals : Loyalty Application',
      'Reservation Book'                        => 'Branch and Location Portals : Reservation Application',
      'Reservation General Settings'            => 'Branch and Location Portals : Reservation Application',
      'Restaurant Exception Days'               => 'Branch and Location Portals : Reservation Application',
      'Restaurant Messaging and Notifications'  => 'Branch and Location Portals : Reservation Application',
      'Restaurant Profile'                      => 'Branch and Location Portals : Web Page',
      'Restaurant Website CSS'                  => 'Branch and Location Portals : Web Page',
      'Restaurant Website Images'               => 'Branch and Location Portals : Web Page',
      'Web Page Analytics'                      => 'Branch and Location Portals : Web Page',
      'Customer Profiles'                       => 'Branch and Location Portals : Customer Profiles',
      'Corporate Portal'                        => 'Corporate Portal',
      'Corporate User Management'               => 'Corporate Portal',
      'Brand Portal'                            => 'Brand Portal',
      'Brand User Management'                   => 'Brand Portal',
    }.each{ |category, section| add_category(category, section) }
    
    add_category('Restaurant Dashboard', 'PS Admin Portal', ['Role'], 'View')
    add_category('SMS', 'Branch and Location Portals : Settings', %w(Product Role))
    add('sms_send', 'SMS', 'Branch and Location Portals : Settings', 'Send Test Message', %w(Product Role), 1, 4, [false])
    add_category('Email', 'Branch and Location Portals : Settings', %w(Product Role))
    add('email_limit', 'Email', 'Branch and Location Portals : Settings', 'Send', %w(Product Role), 2, 4, [false,0], " up to ***1:text:9** Emails")

    add_category('Transactional Templates', 'PS Admin Portal', ['Role'], %w(create view delete updatemerchant updateadmin updatedealer))
    add_category('Administrative Settings', 'PS Admin Portal', ['Role'], %w(update))
    
    add_category('Social Media', 'Branch and Location Portals : Social Media', %w(Product Role), %w(FacebookConnect TwitterConnect WebsiteConnect SocialFeedback Reports))
    add_category('Social Media Posts', 'Branch and Location Portals : Social Media', %w(Product Role))
    %w(Contact Home Menu Press WhatsNew).each do |name|
      add_category("Web Pages : #{name}", 'Branch and Location Portals : Web Page', %w(Product Role))
    end

    ['Marketing Engine', 'Online Ordering', 'Loyalty', 'Webpage Builder', 'eGift', 'Guest Management', 'Mobile Marketing', 'Offers and Incentives'].each do |feature_bit|
      add_category(feature_bit, 'Solutions', %w(Product), %w(On))
    end
    add_category('Online Reservations', 'Solutions', %w(Product), %w(Integrated Standalone))
    
    add_category('GM Application Roles', 'Guest Management', %w(Role), %w(ApplicationAdmin StoreAdmin Host), :one_or_none)

    add_category('OO Roles', 'Online Ordering', %w(Role), %w(MerchantManager ReportManager CallCenterEmployee), :one_or_none)
    add_category('Report Manager User Rights', 'Online Ordering', %w(Role), %w(ConsoleUser MercuryPaymentsEdit StoreManager VoidOrder TransferOrder))

    add_category('eGift Roles',  'eGift', %w(Role), %w(Admin Staff Merchant), :one_or_none)
    add_category('eGift Rights', 'eGift', %w(Role), %w(SalesPageOption GiftCards EmailCampaign SystemVariables SiteContent IPRestriction PaymentConfiguration NewMerchant Reports Search))

    add_category('Store ID', 'Branch and Location Portals : Settings', ['Role'], 'View')
    
    add_category('POS API Key', 'Branch and Location Portals : Settings', ['Role'], 'Generate')

    add_category('Opt-in Opt-out', 'Branch and Location Portals : Customer Profiles', ['Role'], %w(opt-in opt-out))

    ['Branch and Location Portals : Settings', 'Brand Portal', 'Corporate Portal'].each do |section|
      add_category("#{section.split(' ').first} Zoura Account", section, ['Role'], 'Update')
    end
    
    add('offers_and_incentives_redeem', 'Offers and Incentives', 'Branch and Location Portals : Marketing Engine', 'Redeem', %w(Product Role), 1, 4, [false])
  end

  def add_category(category, section, applicability=['Role'], actions=%w(View Create Update Delete), category_allows = :multiple)
    actions = [actions] unless actions.kind_of?(Array)
    actions.collect do |action|
      add("#{key_token(category)}_#{key_token(action)}", category, section, action, applicability, 1, actions.index(action)+1, [false], '', category_allows)
    end
  end
  
  def key_token(token); token.downcase.gsub('-','_').gsub(':','').gsub('  ',' ').gsub(' ','_'); end
end
