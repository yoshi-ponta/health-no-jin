Group.where(invite_token: [ nil, "" ]).find_each do |g|
  g.update_columns(
    invite_token: SecureRandom.base58(22),
  )
end
