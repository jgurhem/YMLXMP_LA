#!/bin/sh

CONF_DIR=$(pwd)

echo "<?xml version=\"1.0\" ?>

<config>
  
  <group name=\"path\" >
    <entry name=\"configs\"  value=\"${PREFIX}/etc/yml/\" />
    <entry name=\"loggers\"  value=\"${PREFIX}/var/yml/logs/\" />
    <entry name=\"plugins\"  value=\"${PREFIX}/lib/yml/2.3\" />
    <entry name=\"programs\" value=\"${PREFIX}/bin/\" />
    <entry name=\"servers\"  value=\"${PREFIX}/sbin/\" />
    <entry name=\"database\" value=\"${PREFIX}/var/yml/data/\" />
    <entry name=\"dr-root\"  value=\"${PREFIX}/var/yml/dr/\" />
    <entry name=\"workdir\"  value=\"${PREFIX}/var/yml/dr/workdir/\" />
    <entry name=\"packin\"   value=\"${PREFIX}/var/yml/dr/packin/\" />
    <entry name=\"packout\"  value=\"${PREFIX}/var/yml/dr/packout/\" />
</group>

  <!-- AccountManager module -->
  <group name=\"AccountManager\" >
    <entry name=\"module\"   value=\"XMLAccountManager\" />
    <entry name=\"init\"     value=\"${PREFIX}/var/yml/accounts.xml\" />
  </group>
  <!-- Development Catalog module -->
  <group name=\"DevelopmentCatalog\" >
    <entry name=\"module\"   value=\"DefaultDevelopmentCatalog\" />
    <entry name=\"init\"     value=\"${CONF_DIR}/var/yml/DefaultDevelopmentCatalog/\" />
  </group>
  <!-- Second Level Scheduler module -->
  <group name=\"Scheduler\" >
    <entry name=\"module\"   value=\"DefaultScheduler\" />
    <entry name=\"init\"     value=\"\" />
  </group>
  <!-- Backend module -->
  <group name=\"Backend\" >
    <entry name=\"module\"   value=\"MpiBackend\" />
    <entry name=\"init\"     value=\"mpi\" />
  </group>
  <!-- Shared by all existing backend execution catalog -->
  <group name=\"DefaultExecutionCatalog\" >
    <entry name=\"module\"   value=\"DefaultExecutionCatalog\" />
    <entry name=\"init\"     value=\"DefaultExecutionCatalog\" />
  </group>
</config>" > yml.xcf
cat yml.xcf

echo "<?xml version=\"1.0\" ?>
<config>
  <group name=\"general\">
    <entry name=\"execution-catalog\"  value=\"DefaultExecutionCatalog\" /> 
    <entry name=\"version\"            value=\"1.0\" />
    <entry name=\"maxNumberRequest\"   value=\"500\" />
    <entry name=\"hostfileDir\"        value=\"${CONF_DIR}/.omrpc_registry\" />
    <entry name=\"verbose\"            value=\"no\" /> 
  </group>
</config>" > mpi.xcf
cat mpi.xcf

echo "<?xml version=\"1.0\"?>
<config>
    <group name=\"path\">
        <entry name=\"binaries\"      value=\"${CONF_DIR}/var/yml/dr/binaries/\" />
        <entry name=\"binaries-uri\"  value=\"/binaries/\" />
        <entry name=\"generators\"    value=\"${PREFIX}/var/yml/DefaultExecutionCatalog/generators/\" />
        <entry name=\"indexes\"       value=\"${PREFIX}/var/yml/DefaultExecutionCatalog/indexes/\" />
    </group>
</config>" > DefaultExecutionCatalog.xcf
cat DefaultExecutionCatalog.xcf

cp *.xcf /gpfshome/mds/staff/jgurhem/local/etc/yml/

mkdir .omrpc_registry
mkdir var
mkdir var/yml
mkdir var/yml/dr
mkdir var/yml/dr/binaries
mkdir var/yml/DefaultDevelopmentCatalog
mkdir var/yml/DefaultDevelopmentCatalog/graph
mkdir var/yml/DefaultDevelopmentCatalog/abstract
mkdir var/yml/DefaultDevelopmentCatalog/implementation

echo "<?xml version=\"1.0\" ?>
<OmniRpcConfig>
<Host name=\"127.0.0.1\" arch=\"i386\" os=\"linux\">
<Agent invoker=\"mpi\" />
<JobScheduler type=\"rr\" maxjob=\"1000\" />
</Host>
</OmniRpcConfig>" > .omrpc_registry/hosts.xml

