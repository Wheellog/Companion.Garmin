include properties.mk

appName = `grep entry manifest.xml | sed 's/.*entry="\([^"]*\).*/\1/'`
devices = `grep 'iq:product id' manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/'`
JAVA_OPTIONS = JDK_JAVA_OPTIONS="--add-modules=java.xml.bind"

build:
	monkeyc \
	--jungles ./monkey.jungle \
	--device $(DEVICE) \
	--output bin/$(appName).prg \
	--private-key $(PRIVATE_KEY) \
	--warn

buildall:
	@for device in $(devices); do \
		echo "-----"; \
		echo "Building for" $$device; \
    monkeyc \
		--jungles ./monkey.jungle \
		--device $$device \
		--output bin/$(appName)-$$device.prg \
		--private-key $(PRIVATE_KEY) \
		--warn; \
	done

run: build
	connectiq
	@sleep 4
	monkeydo bin/$(appName).prg $(DEVICE)

deploy: build
	@cp bin/$(appName).prg $(DEPLOY)

package:
	monkeyc \
	--jungles ./monkey.jungle \
	--package-app \
	--release \
	--output bin/$(appName).iq \
	--private-key $(PRIVATE_KEY) \
	--warn