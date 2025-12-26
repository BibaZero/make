PROJECT_DIR		:= .
INCLUDE_DIR		:= $(PROJECT_DIR)/inc
SOURCE_DIR		:= $(PROJECT_DIR)/src
OUTPUT_DIR		:= $(PROJECT_DIR)/output
TARGET_File		:= $(PROJECT_DIR)/output/main.exe

CC				:= gcc

SOURCE_FILES	:= $(wildcard $(SOURCE_DIR)/*.c)

OBJECT_FILES	:= $(notdir $(subst .c,.o,$(SOURCE_FILES)))
OBJECT_PATHS	:= $(foreach file,$(OBJECT_FILES),$(OUTPUT_DIR)/$(file))

INCLUDE_FILES	:= $(notdir $(subst .c,.h,$(SOURCE_FILES)))
INCLUDE_FILES	:= $(foreach file,$(INCLUDE_FILES),$(INCLUDE_DIR)/$(file))


all: $(OUTPUT_DIR) $(OBJECT_PATHS)
	$(CC) $(OBJECT_PATHS) -o $(TARGET_File)

$(OUTPUT_DIR)/%.o: $(SOURCE_DIR)/%.c $(INCLUDE_FILES)
	$(CC) -I $(INCLUDE_DIR) -c $< -o $@

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

run: clean all
	$(TARGET_File)

clean:
	rm -rf $(OUTPUT_DIR) main.exe

print-%:
	@echo $($(subst print-,,$@))
