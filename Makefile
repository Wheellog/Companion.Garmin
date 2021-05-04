include properties.mk

appName = `grep entry manifest.xml | sed 's/.*entry="\([^"]*\).*/\1/'`
devices = `grep 'iq:product id' manifest.xml | sed 's/.*iq:product id="\([^"]*\).*/\1/'`

build:
	@monkeyc \
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
	@sleep 2
	monkeydo bin/$(appName).prg $(DEVICE)

deploy: build
	@cp bin/$(appName).prg $(DEPLOY)

package:
	@echo "Building release app for Connect IQ Store..."
	@monkeyc \
	--jungles ./monkey.jungle \
	--package-app \
	--release \
	--output bin/$(appName).iq \
	--private-key $(PRIVATE_KEY) \
	--warn

clean:
	@rm -rf bin

rerun: build
	connectiq
	monkeydo bin/$(appName).prg $(DEVICE)

clean-xml:
	rm -rf bin/*.xml

clean-json:
	rm -rf bin/*.json

generate-devkey:
	openssl genrsa -out id_rsa_garmin.pem 4096
	openssl pkcs8 -topk8 -inform PEM -outform DER -in id_rsa_garmin.pem -out id_rsa_garmin.der -nocrypt

check-deployment:
	@./makescripts/check-deployment.sh
