
context = ChefDK::Generator.context
cookbook_dir = context.cookbook_root
recipe_path = File.join(cookbook_dir, "recipes", "#{context.new_file_basename}.rb")
spec_helper_path = File.join(cookbook_dir, "spec", "spec_helper.rb")
spec_path = File.join(cookbook_dir, "spec", "unit", "recipes", "#{context.new_file_basename}_spec.rb")
inspec_path = File.join(cookbook_dir, "test", "recipes", "#{context.new_file_basename}.rb")

# Chefspec
directory "#{cookbook_dir}/spec/unit/recipes" do
  recursive true
end

cookbook_file spec_helper_path do
  action :create_if_missing
end

template spec_path do
  source "recipe_spec.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Inspec
directory "#{cookbook_dir}/test/recipes" do
  recursive true
end

template inspec_path do
  source 'inspec_default_test.rb.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Recipe
template recipe_path do
  source "recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
end

