SRC_DIR = src
TEST_DIR = test
BUILD_DIR = dist

LEXER_SRC = $(SRC_DIR)/LexicalAnalyzer.flex
LEXER_JAVA = $(SRC_DIR)/LexicalAnalyzer.java
JAR_NAME = part1.jar

JAVAC = javac
JAVA = java
JFLAGS = -d $(BUILD_DIR)


all: $(BUILD_DIR)/$(JAR_NAME)

$(LEXER_JAVA): $(LEXER_SRC)
	jflex $(LEXER_SRC)

compile: $(LEXER_JAVA)
	mkdir -p $(BUILD_DIR)
	$(JAVAC) $(JFLAGS) $(SRC_DIR)/*.java
	cd $(BUILD_DIR) && jar cfe $(JAR_NAME) Main *.class

$(BUILD_DIR)/$(JAR_NAME) : compile

run:
	$(JAVA) -jar $(BUILD_DIR)/$(JAR_NAME) Euclid.ycc

clean:
	rm -rf $(BUILD_DIR) $(SRC_DIR)/LexicalAnalyzer.java $(SRC_DIR)/LexicalAnalyzer.java~
