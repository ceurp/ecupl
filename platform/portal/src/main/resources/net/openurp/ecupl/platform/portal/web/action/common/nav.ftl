[#assign username=user.name/]
<table class="navbar">
 <tbody>
     <tr width="100%">
      <td valign="middle"  class="TabMiddle">&nbsp;<a [#if self_action =='/index/index'] class="active" [/#if]href="${base}/">我的首页</a>&nbsp;</td>
      <td class="TabSeperator"></td>
      [#if user.category.id == 1 ]
      <td valign="middle"  class="TabMiddle">&nbsp;<a [#if self_action =='/teaching/index'] class="active" [/#if]href="${base}/teaching">我的教学</a> &nbsp;</td>
      <td class="TabSeperator"></td>
      [#elseif user.category.id == 2 ]
      <td valign="middle"  class="TabMiddle">&nbsp;<a [#if self_action =='/study/index'] class="active" [/#if]href="${base}/study">我的学习</a> &nbsp;</td>
      <td class="TabSeperator"></td>
      [/#if]
      <td class="TabTail" >&nbsp;</td>
    </tr>
  </tbody>
 </table>
