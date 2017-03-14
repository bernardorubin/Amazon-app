json.more_products @more_products

json.products @products do |product|
  json.id product.id
  json.title product.title
  json.description product.description
  json.price product.price
  json.created_on product.created_at.strftime('%Y-%B-%d')
  json.url api_v1_product_path(product)
end
