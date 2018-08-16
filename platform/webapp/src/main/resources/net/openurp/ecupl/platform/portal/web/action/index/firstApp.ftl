[#ftl]
[@b.head]
<script type="text/javascript">
    var webappBase='${webappBase}';
    [#noparse]var firstUrl = ${apps.first}.url.replace('{openurp.webapp}',webappBase);document.location=firstUrl;[/#noparse]
</script>
[@b.foot/]
