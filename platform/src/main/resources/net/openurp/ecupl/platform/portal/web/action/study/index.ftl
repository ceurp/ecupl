[#include "../common/lib.ftl"/]

[@head/]
[#include "../common/top.ftl"/]
[#include "../common/nav.ftl"/]

<div style="width:1000px;margin:auto">
<table width="100%"><tbody><tr><td style="background-color: #FFFFFF">

<div style="float: left ;  width:23%; "  >
  [#include "services.ftl"/]
</div>

<div style="float: left ;  width:77%; "  >
  [#include "weektable.ftl"/]
</div>

</td></tr></tbody></table>
</div>

[@foot]
<script>
var contextPath="${base}"
</script>
<script src="${static_base}/scripts/default.js" type="text/javascript" language="JavaScript"></script>
[/@]
