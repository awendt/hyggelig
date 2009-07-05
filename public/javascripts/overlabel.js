var overLabelPlugin = {
 overlabel: function (obj)
 {
  var  field;

  obj = $(obj);

  // check for attribute
  if(!obj.readAttribute('for') ||
   !(field = $(obj.readAttribute('for'))))
    return false;

  // apply overlabel style
  obj.className = 'overlabel-apply';
  if(field.value != '')
   $$('label[for='+$(field).readAttribute('id')+']').invoke('hide');

  // setup event handlers
  field.onfocus = function ()
  {
   $$('label[for='+$(this).readAttribute('id')+']').invoke('hide');
  }

  field.onblur = function ()
  {
   if($(this).value === '')
    $$('label[for='+$(this).readAttribute('id')+']').invoke('show');
  }

  obj.onclick = function ()
  {
   $($(this).readAttribute('for')).focus();
  }
 }
}

Event.observe(window,'load',function () {
 Element.addMethods(overLabelPlugin);
 $$('.overlabel').invoke('overlabel');
});
