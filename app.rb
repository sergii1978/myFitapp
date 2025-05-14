require 'sinatra'
require 'yaml'
require 'erb'

# Налаштування
configure do
  set :locales_path, File.join(settings.root, 'locales')
  set :default_lang, 'uk'
  set :supported_langs, %w[uk en]
end

# Завантажити переклади
def load_translations
  settings.supported_langs.each_with_object({}) do |lang, all|
    path = File.join(settings.locales_path, "#{lang}.yml")
    all[lang] = YAML.load_file(path)[lang]
  end
end

TRANSLATIONS = load_translations

# Хелпери
helpers do
  def t(key)
    lang = session[:lang] || settings.default_lang
    TRANSLATIONS.dig(lang, *key.to_s.split('.')) || key
  end

  def current_lang
    session[:lang] || settings.default_lang
  end

  def theme_class
    (request.cookies['theme'] || 'light') == 'dark' ? 'dark-theme' : 'light-theme'
  end

  def page_title
    @title || t('seo.title')
  end

  def page_description
    @description || t('seo.description')
  end
end

# Перед кожним запитом
before do
  session[:lang] ||= settings.default_lang
end

# Перемикач мови
get '/lang/:lang' do
  lang = params[:lang]
  session[:lang] = lang if settings.supported_langs.include?(lang)
  redirect back
end

# Тема
get '/theme/:mode' do
  response.set_cookie('theme', value: params[:mode], path: '/')
  redirect back
end

# Сторінки
get '/' do
  @title = t('seo.title')
  erb :index
end

get '/about'     do erb :about end
get '/services'  do erb :services end
get '/trainers'  do erb :trainers end
get '/schedule'  do erb :schedule end
get '/gallery'   do erb :gallery end
get '/contact'   do erb :contact end

# 404
not_found do
  status 404
  erb :not_found
end
