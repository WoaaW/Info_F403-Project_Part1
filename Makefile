SRC_DIR = src
TEST_DIR = test
BUILD_DIR = dist

LEXER_SRC = $(SRC_DIR)/LexicalAnalyzer.flex
LEXER_JAVA = $(SRC_DIR)/LexicalAnalyzer.java

JAVAC = javac
JAVA = java
JFLAGS = -d $(BUILD_DIR)


all: $(LEXER_JAVA) compile

$(LEXER_JAVA): $(LEXER_SRC)
	jflex $(LEXER_SRC)

compile:
	mkdir -p $(BUILD_DIR)
	$(JAVAC) $(JFLAGS) $(SRC_DIR)/*.java

run:
	$(JAVA) -cp $(BUILD_DIR) Main $(TEST_DIR)/Euclid.ycc

clean:
	rm -rf $(BUILD_DIR) $(SRC_DIR)/LexicalAnalyzer.java $(SRC_DIR)/LexicalAnalyzer.java~
