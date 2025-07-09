#! SIMPLE COMMANDS
#! ANSI COLOUR CODES
ORANGE=\033[0;33m
GREEN=\033[38;5;35m
PURPLE=\033[0;35m

#! FUNCTION TO CREATE A BOX AROUND A TEXT
define box
	@echo "$(GREEN)╔══════════════════════════════════════╗$(ORANGE)"
	@echo "$(GREEN)║$(ORANGE) $1$(GREEN) ║$(ORANGE)"
	@echo "$(GREEN)╚══════════════════════════════════════╝$(ORANGE)"
endef

#! FUNCTION TO DISPLAY LOADING ANIMATION
define loading
	@chars='| / - \\'; \
	for i in $$(seq 1 10); do \
		for c in $$chars; do \
			printf "\r$(PURPLE)🔄 Loading... $$c$(RESET)"; \
			sleep 0.1; \
		done; \
	done; \
	printf "\r$(GREEN)✅ Done!          $(RESET)\n"
endef


.PHONY: analyze br build buildAPK cleanAndBuild cleanAndGet createLauncherIcons createSplashScreen pubGet runRelease gitFetchAndCheckoutStaging patrolSendToBank cleanIOS deploy ios_deploy android_deploy cleanSweepiOS

analyze:
	flutter analyze

br:
	dart run build_runner watch --delete-conflicting-outputs
	$(call box,$(ORANGE):::BUILD RUNNER WATCH $(PURPLE)   ==>> $(GREEN)Done.)

build:
	flutter pub get && flutter build appbundle --release
	$(call box,$(ORANGE)::: PROJECT BUILD COMMAND  $(PURPLE)==>> $(GREEN)Done)

buildAPK:
	flutter pub get && flutter build apk --release && flutter build appbundle --release
	$(call box,$(ORANGE)::: PROJECT BUILD COMMAND  $(PURPLE)==>> $(GREEN)Done)

cleanAndBuild:
	flutter clean && flutter pub get && flutter build apk --release
	$(call box,$(ORANGE)::: CLEAN AND BUILD COMMAND  $(PURPLE)==>> $(GREEN)Done)

cleanAndGet:
	flutter clean && flutter pub get && clear
	$(call box,$(ORANGE)::: CLEAN AND GET COMMAND $(PURPLE)==>> $(GREEN)Done.)

createLauncherIcons:
	dart run flutter_launcher_icons
	$(call box,$(ORANGE)::: FLUTTER LAUNCHER ICONS $(PURPLE)==>> $(GREEN)Done)

createSplashScreen:
	dart run flutter_native_splash:create
	$(call box,$(ORANGE)::: FLUTTER LAUNCHER ICONS $(PURPLE)==>> $(GREEN)Done)

gitFetchAndCheckoutStaging:
	git fetch --prune --all && git pull --all && git checkout staging && git pull && git remote prune origin
	$(call box,$(ORANGE)::: GIT FETCH & PULL ALL BRANCHES THEN CHECKOUT TO STAGING $(PURPLE)==>> $(GREEN)Done)

pubGet:
	flutter pub get && clear
	$(call box,$(ORANGE):::PUB GET COMMAND $(PURPLE)   ==>> $(GREEN)Done.)

runRelease:
	flutter pub get && flutter run --release
	$(call box,$(ORANGE)::: PROJECT BUILD COMMAND  $(PURPLE)==>> $(GREEN)Done)

cleanIOS:
	$(call box,$(ORANGE)🚀 STARTING PROJECT CLEANUP $(PURPLE)==>>)
	$(call loading)
	flutter clean
	cd ios && rm -rf Pods Podfile.lock && cd ..
	flutter pub get
	cd ios && pod install
	$(call box,$(GREEN)🎉 PROJECT BUILD COMPLETE $(PURPLE)==>> $(GREEN)Done)

cleanIOSUpdate:
	$(call box,$(ORANGE)🚀 STARTING PROJECT CLEANUP $(PURPLE)==>>)
	$(call loading)
	flutter clean
	cd ios && rm -rf Pods Podfile.lock && cd ..
	flutter pub get
	cd ios && pod install --repo-update
	$(call box,$(GREEN)🎉 PROJECT BUILD COMPLETE $(PURPLE)==>> $(GREEN)Done)

cleanSweepiOS:
	rm -rf ~/Library/Developer/Xcode/DerivedData && flutter clean && rm -rf ios/Pods && rm -rf ios/.symlinks && rm -rf ios/Flutter/Flutter.framework && rm -rf ios/Flutter/Flutter.podspec && flutter pub get && cd ios && pod deintegrate && pod install && pod install --repo-update && cd ../ && flutter pub get && flutter build ipa --release
	$(call box,$(ORANGE)::: CLEAN SWEEP iOS COMMAND $(PURPLE)==>> $(GREEN)Done.)

deploy: 
	$(call box, 🚀 Starting Deployment...)
	@make -j ios_deploy android_deploy

ios_deploy:
	$(call box, 📱 Deploying iOS...)
	$(call loading)
	cd ios && fastlane development
	$(call box, ✅ iOS Deployment Done!)

android_deploy:
	$(call box, 🤖 Deploying Android...)
	$(call loading)
	cd android && fastlane development
	$(call box, ✅ Android Deployment Done!)

patrolSendToBank:
	patrol test -t integration_test/send_to_bank_test.dart
	$(call box,$(ORANGE)::: PATROL SEND TO BANK TEST  $(PURPLE)==>> $(GREEN)Done)
