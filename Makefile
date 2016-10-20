JARNAME:=VncThumbnailViewer.jar
BINDIR:=bin
OUTDIR:=build
SRCDIR:=src

JAVAC?=javac
JAR?=jar

EXTLIBS:=net
CP:=-classpath lib
SRCS:=$(wildcard $(SRCDIR)/*.java)
CLASSES:=$(patsubst $(SRCDIR)/%, $(OUTDIR)/%, $(SRCS:.java=.class))


default : $(BINDIR)/$(JARNAME)

clean :
	rm -fr $(OUTDIR)

$(OUTDIR)/%.class : $(SRCDIR)/%.java

$(CLASSES) :
	@mkdir -p $(dir $@)
	$(JAVAC) -d $(dir $@) $(CP) $(SRCS)

$(BINDIR)/$(JARNAME) : $(CLASSES)
	@mkdir -p $(dir $@)
	$(JAR) cf $@ $(addprefix -C $(OUTDIR) ,$(notdir $(CLASSES))) $(addprefix -C lib ,$(EXTLIBS))

# Debug target for printing variables. You can use "$ make print-CLASSES" for example
print-%: ; @echo $* is $($*)

