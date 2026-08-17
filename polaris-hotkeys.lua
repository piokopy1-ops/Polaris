obs = obslua

local source_name = "Polaris Alert"
local overlay_url = "https://piokopy1-ops.github.io/Polaris/overlay.html"
local hotkeys = {}
local trigger_counter = 0

local alerts = {
  missable = true,
  choice = true,
  collectible = true,
  save = true,
  hide = true,
}

local function trigger(alert_type)
  if not alerts[alert_type] then return end

  trigger_counter = trigger_counter + 1

  local source = obs.obs_get_source_by_name(source_name)
  if source == nil then
    obs.script_log(obs.LOG_WARNING, "Nie znaleziono źródła przeglądarki: " .. source_name)
    return
  end

  local settings = obs.obs_source_get_settings(source)
  local url = overlay_url .. "?hotkey=" .. alert_type .. "&t=" .. tostring(os.time()) .. "-" .. tostring(trigger_counter)
  obs.obs_data_set_string(settings, "url", url)
  obs.obs_source_update(source, settings)
  obs.obs_data_release(settings)
  obs.obs_source_release(source)
end

local function register_hotkey(settings, key, label, alert_type)
  local callback = function(pressed)
    if pressed then trigger(alert_type) end
  end
  local id = obs.obs_hotkey_register_frontend("polaris_" .. key, label, callback)
  hotkeys[key] = {id = id, callback = callback}
  local saved = obs.obs_data_get_array(settings, "hotkey_" .. key)
  obs.obs_hotkey_load(id, saved)
  obs.obs_data_array_release(saved)
end

function script_description()
  return "Globalne skróty do nakładki Polaris Alert. Wybierz nazwę źródła przeglądarki, a następnie przypisz klawisze w Ustawienia → Skróty klawiszowe."
end

function script_properties()
  local props = obs.obs_properties_create()
  obs.obs_properties_add_text(props, "source_name", "Nazwa źródła przeglądarki", obs.OBS_TEXT_DEFAULT)
  obs.obs_properties_add_text(props, "overlay_url", "Adres nakładki", obs.OBS_TEXT_DEFAULT)
  return props
end

function script_defaults(settings)
  obs.obs_data_set_default_string(settings, "source_name", "Polaris Alert")
  obs.obs_data_set_default_string(settings, "overlay_url", "https://piokopy1-ops.github.io/Polaris/overlay.html")
end

function script_update(settings)
  source_name = obs.obs_data_get_string(settings, "source_name")
  overlay_url = obs.obs_data_get_string(settings, "overlay_url")
  overlay_url = overlay_url:match("^[^?]+") or overlay_url
end

function script_load(settings)
  register_hotkey(settings, "missable", "Polaris: pomijalne osiągnięcie", "missable")
  register_hotkey(settings, "save", "Polaris: zrób zapis", "save")
  register_hotkey(settings, "choice", "Polaris: ważny wybór", "choice")
  register_hotkey(settings, "collectible", "Polaris: przedmiot w pobliżu", "collectible")
  register_hotkey(settings, "hide", "Polaris: ukryj alert", "hide")
end

function script_save(settings)
  for key, hotkey in pairs(hotkeys) do
    local saved = obs.obs_hotkey_save(hotkey.id)
    obs.obs_data_set_array(settings, "hotkey_" .. key, saved)
    obs.obs_data_array_release(saved)
  end
end
