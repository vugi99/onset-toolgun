# onset-toolgun

### Setup
* Download the package
* Extract it in your packages
* Rename it to "toolgun"
* Add this to your weapons.json :
```
               {
			"Name": "Toolgun",
			"RateOfFire": 150.0,
			"Damage": 0.0,
			"Range": 13000.0,
			"Recoil": 0.0,
			"MagazineSize": 100,
			"CameraShake": 0.0,
			"CameraShakeCrouching": 0.0,
			"SpreadMin": 0.1,
			"SpreadMax": 0.2,
			"SpreadMovementModifier": 0.2,
			"SpreadCrouchingModifier": -0.3
		}
```
* Config the package in the config.lua file
* Do /toolgun (by default) to give the toolgun

### Developers
* Example tools in cl_tools.lua