class Settings
	@fields = {}
	@categories = []
	
	@add: (category, name, object) ->
		@fields[category]?={}
		@fields[category][name] = object
		@categories.push(category) if @categories.indexOf(category)==-1
	
	@show: (category = @categories[0]) -> 
		

Settings.add("Allgemeines", "Konten", "Liste aller dem Geotweeter bekannten Twitter-Accounts.", new SettingsList({
	count: -> settings.twitter.users.length
	getValue: (i) -> settings.twitter.users[i].screen_name || settings.twitter.users[i].token
	deleteValue: (i) -> settings.twitter.splice(i, 1) if confirm("Wirklich den gewählten User-Account löschen?")
	addValue: Hooks.add_user_1
}))

Settings.add("Allgemeines", "ConsumerKey", "Der vom Geotweeter verwendete ConsumerKey. Achtung: Wird er geändert, müssen alle Accounts neu hinzugefügt werden!", new SettingsText({
	getValue: -> settings.twitter.consumerKey
	setValue: (val) -> settings.twitter.consumerKey = val
}))

Settings.add("Allgemeines", "ConsumerSecret", "Der vom Geotweeter verwendete ConsumerSecret. Achtung: Wird er geändert, müssen alle Accounts neu hinzugefügt werden!", new SettingsText({
	getValue: -> settings.twitter.consumerSecret
	setValue: (val) -> settings.twitter.consumerSecret = val
}))

Settings.add("Allgemeines", "Places", "Im Geotweeter verwendbare Orte", new SettingsList({
	count: -> settings.places.length
	getValue: (i) -> 
		p = settings.places[i]
		[p.name, p.lat, p.lon]
	deleteValue: (i) -> settings.places.splice(i, 1) if confirm("Wirklich den gewählten Ort löschen?")
	listHeaders: ["Name", "Lat", "Lon"]
	addValue: Hooks.add_location_1
}))