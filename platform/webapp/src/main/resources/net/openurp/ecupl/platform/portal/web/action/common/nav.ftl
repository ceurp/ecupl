[#assign username=user.name/]
<table class="navbar">
 <tbody>
     <tr width="100%">
      <td valign="middle"  class="TabMiddle">&nbsp;<a [#if self_action =='/portal/index'] class="active" [/#if]href="${base}/portal/index">我的首页</a>&nbsp;</td>
      <td class="TabSeperator"></td>
      [#if user.category.id == 1 ]
      <td valign="middle"  class="TabMiddle">&nbsp;<a [#if self_action =='/portal/teaching'] class="active" [/#if]href="${base}/portal/teaching">我的教学</a> &nbsp;</td>
      <td class="TabSeperator"></td>
      [#elseif user.category.id == 2 ]
      <td valign="middle"  class="TabMiddle">&nbsp;<a [#if self_action =='/portal/study'] class="active" [/#if]href="${base}/portal/study">我的学习</a> &nbsp;</td>
      <td class="TabSeperator"></td>
      [/#if]
      <td class="TabTail" >&nbsp;</td>
    </tr>
  </tbody>
 </table>
