# === Directories ===
SRC_DIR = src
TEST_DIR = test
BUILD_DIR = dist
DOC_DIR = doc

# === Files ===
TEST_FILES := $(wildcard $(TEST_DIR)/*.ycc)
LEXER_SRC = $(SRC_DIR)/LexicalAnalyzer.flex
LEXER_JAVA = $(SRC_DIR)/LexicalAnalyzer.java
JAR_NAME = part1.jar

# === Tools ===
JAVAC = javac
JAVA = java
JFLAGS = -d $(BUILD_DIR)

# === Cross-platform mkdir / rm ===
# We’ll use PowerShell-safe commands on Windows.
ifeq ($(OS),Windows_NT)
    MKDIR = powershell -Command "New-Item -ItemType Directory -Force -Path '$(1)' | Out-Null"
    RMDIR = powershell -Command "Remove-Item -Recurse -Force -ErrorAction SilentlyContinue '$(1)'"
    RM = powershell -Command "Remove-Item -Force -ErrorAction SilentlyContinue '$(1)'"
else
    MKDIR = mkdir -p $(1)
    RMDIR = rm -rf $(1)
    RM = rm -f $(1)
endif

# === Targets ===
.PHONY: all compile run test doc clean

all: $(BUILD_DIR)/$(JAR_NAME)

$(LEXER_JAVA): $(LEXER_SRC)
	jflex $(LEXER_SRC)

compile: $(LEXER_JAVA)
	@$(call MKDIR,$(BUILD_DIR))
	$(JAVAC) $(JFLAGS) $(SRC_DIR)/*.java
	cd $(BUILD_DIR) && jar cfe $(JAR_NAME) Main *.class

$(BUILD_DIR)/$(JAR_NAME): compile

run:
	$(JAVA) -jar $(BUILD_DIR)/$(JAR_NAME) $(TEST_DIR)/Euclid.ycc

test: compile
	@for test_file in $(TEST_FILES); do \
		echo "Running $$test_file"; \
		$(JAVA) -jar $(BUILD_DIR)/$(JAR_NAME) "$$test_file"; \
	done

doc:
	@$(call MKDIR,$(DOC_DIR))
	javadoc -d $(DOC_DIR) $(SRC_DIR)/*.java

clean:
	@$(call RMDIR,$(BUILD_DIR))
	@$(call RM,$(LEXER_JAVA))
	@$(call RMDIR,$(DOC_DIR))
