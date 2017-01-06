.PHONY: all clean distclean

NODE_DIR := node_modules

# node binaries
NPM_BIN := $(NODE_DIR)/.bin
COFFEE_CC := $(NPM_BIN)/coffee
BROWSERIFY := $(NPM_BIN)/browserify

DEPS := $(COFFEE_CC) $(BROWSERIFY)

# opts
COFFEE_OPTS := -bc --no-header

# target-specific stuff
COMMON_DIR := ./common
COFFEE_COMMON := $(wildcard $(COMMON_DIR)/*.coffee)

CHROME_DIR := ./chrome
CHROME_INJECT_IN := $(COMMON_DIR)/replace-all.js $(CHROME_DIR)/replace.js
CHROME_INJECT_BUNDLE := $(CHROME_DIR)/inject-bundle.js
CHROME_BACKGROUND_IN := $(CHROME_DIR)/toggle.js
CHROME_BACKGROUND_BUNDLE := $(CHROME_DIR)/background-bundle.js

# targets
IN_COFFEE := $(wildcard $(CHROME_DIR)/*.coffee)
OUT_JS := $(patsubst %.coffee,%.js,$(IN_COFFEE))

# recipes
all: $(CHROME_BACKGROUND_BUNDLE) $(CHROME_INJECT_BUNDLE) $(OUT_JS)

$(CHROME_BACKGROUND_BUNDLE): $(CHROME_BACKGROUND_IN) $(BROWSERIFY)
	$(BROWSERIFY) $(CHROME_BACKGROUND_IN) -o $@

$(CHROME_INJECT_BUNDLE): $(CHROME_INJECT_IN) $(BROWSERIFY)
	$(BROWSERIFY) -r $(CHROME_INJECT_IN) -o $@

# require is a built in function here, so we just copy
%.js: %.coffee $(COFFEE_CC)
	$(COFFEE_CC) $(COFFEE_OPTS) $<

clean:
	rm -f $(OUT_JS) $(CHROME_BACKGROUND_BUNDLE) $(CHROME_BACKGROUND_IN) \
		$(CHROME_INJECT_BUNDLE) $(CHROME_INJECT_IN)

distclean: clean
	rm -rf $(NODE_DIR)

$(DEPS):
	npm install
