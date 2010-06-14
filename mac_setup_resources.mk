# targets:
#    resinstall
#	 datainstall
#    shipinstall
#
# required variables:
#    TORCS_BASE    - torcs source dir
#    MAKE_DEFAULT  - this file
#    datadir       - destination dir
#
# example:
#   cd torcs-1.3.1
#   make resinstall TORCS_BASE=$PWD MAKE_DEFAULT=$PWD/../mac_setup_resources.mk \
#     datadir=$PWD/../../RES
#
# - CL

ifndef TORCS_BASE
error:
	@echo "TORCS_BASE should be defined"
	@exit 1
endif

INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644

mkinstalldirs = $(SHELL) $(TORCS_BASE)/mkinstalldirs

INSTDATABASE = ${DESTDIR}${datadir}
INSTVARBASE  = ${DESTDIR}${datadir}

define recursedirs
for Dir in $$RecurseDirs ;\
do ${MAKE} -C $$Dir $$RecurseFlags TORCS_BASE=${TORCS_BASE} MAKE_DEFAULT=${MAKE_DEFAULT}; \
if [ $$? != 0 ]; then exit 1; fi ; \
done
endef

# Recursive targets

.PHONY: datainstall installdata installdatadirs makedatadir shipinstall installship installshipmkdir instshipdirs installshipdirs

resinstall: datainstall shipinstall

datainstall: installdatadirs installdata

installdata: makedatadir $(patsubst %, ${INSTDATABASE}/${DATADIR}/%, $(DATA))

makedatadir:
	@D=`pwd` ; \
	createdir="${INSTDATABASE}/${DATADIR}" ; \
	$(mkinstalldirs) $$createdir

$(patsubst %, ${INSTDATABASE}/${DATADIR}/%, $(DATA)) : ${INSTDATABASE}/${DATADIR}/% : %
	$(INSTALL_DATA) $< $@

instdatadirs:
	@RecurseDirs="${DATASUBDIRS}" ; \
	RecurseFlags="install" ; \
	${recursedirs}

installdatadirs:
	@if [ -n "${DATASUBDIRS}" ] ; \
	then R=`for I in ${DATASUBDIRS} ; \
	do echo $$I ;\
	done | sort -u` ; \
	RecurseDirs="$$R" ; \
	RecurseFlags="datainstall" ; \
	${recursedirs} ; \
	fi


shipinstall: installshipdirs installship installshipmkdir

installship: makeshipdir $(patsubst %, ${INSTDATABASE}/${SHIPDIR}/%, $(SHIP))

makeshipdir:
	@D=`pwd` ; \
	createdir="${INSTDATABASE}/${SHIPDIR}" ; \
	$(mkinstalldirs) $$createdir

$(patsubst %, ${INSTDATABASE}/${SHIPDIR}/%, $(SHIP)) : ${INSTDATABASE}/${SHIPDIR}/% : %
	$(INSTALL_DATA) $< $@

installshipmkdir:
	@for D in  $(SHIPCREATEDIRS) ; \
	do echo " Creating ${INSTVARBASE}/$$D Directory" ; \
	$(mkinstalldirs) ${INSTVARBASE}/$$D ; \
	done

instshipdirs:
	@RecurseDirs="${SHIPSUBDIRS}" ; \
	RecurseFlags="install" ; \
	${recursedirs}

installshipdirs:
	@if [ -n "${SHIPSUBDIRS}" ] ; \
	then R=`for I in ${SHIPSUBDIRS} ; \
	do echo $$I ;\
	done | sort -u` ; \
	RecurseDirs="$$R" ; \
	RecurseFlags="shipinstall" ; \
	${recursedirs} ; \
	fi
