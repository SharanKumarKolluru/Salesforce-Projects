({
	ChangeFunction : function(component, event, helper) {
		component.set("v.UN_Code",component.get('v.countryInfo._id'));
        component.set("v.iso2",component.get('v.countryInfo.iso2'));
        component.set("v.iso3",component.get('v.countryInfo.iso3'));
        component.set("v.Latitude",component.get('v.countryInfo.lat'));
        component.set("v.Longitude",component.get('v.countryInfo.long'));
        component.set("v.FlagUrl",component.get('v.countryInfo.flag'));	
        component.set("v.SelectedCountry",component.get('v.country'))
	}
})
