// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



$(document).ready(function() {
  docReady();
})

$(document).bind('beforeReveal.facebox', function() {
    var height = $(window).height() - 100;
    $('#facebox .content').css('height', height + 'px');
    $('#facebox').css('top', ($(window).scrollTop() + 10) + 'px');
});

//esta funcion la ejecuto cuando "domcument ready" (arriba), la tengo dentro de esta named function porque cuando
//ejecuto un ajax debo llamar desde ese ajax a esta named function para simuar el "document ready"
function docReady(){

    $(".on_blur_ajax").blur(function() {
        if(this.value.length > 0 && $("#" + this.getAttribute("data_start_date_id")).val().length > 0 ){
            $.post("/tasks/ajax_display_planned_end_date", $("#" + this.getAttribute("data_form_id")).serialize(), null, "script");
            return false;
        }
    });

    //funcion para el manejo del form de project y la carga de valores de las phases
    $("#project_life_cycle_id").change(function() {
        $.post("/projects/ajax_display_phases_form", $(".simple_form.project").serialize(), null, "script");
    });


    //este par de funciones son para hacer que un form se submita con ajax, al form hay que ponerle class="submit_with_ajax"
    jQuery.fn.submitWithAjax = function() {
      this.submit(function() {
        $.post(this.action, $(this).serialize(), null, "script");
        return false;
      })
      return this;
    };
    $(document).ready(function() {
      $(".submit_with_ajax").submitWithAjax();
    })


    // ajax para cuando cambia un dropdown haga algo. Ej: cargar un dropdown segun el valor de otro dropdown, u otra cosa
    $(function($) {
        $(".ajax_dropdown").change(function() {
            $('input[type=submit]').attr('disabled', true);
            $.ajax({url: this.getAttribute("data-url"),
                data: this.getAttribute("data-parameter") + '=' + this.value,
                dataType: 'script'})
        });
    });


    // ajax para mostrar la exposicion de riesgo cuando se elije el impacto y la probabilidad
    $(function($) {
        $("#risk_risk_impact_id, #risk_risk_probability_id").change(function() {
            $.ajax({url: '/risks/ajax_calculate_risk_exposition',
                data: 'risk[risk_impact_id]=' + $("#risk_risk_impact_id").val() + '&risk[risk_probability_id]=' + $("#risk_risk_probability_id").val(),
                dataType: 'script'})
        });
    });


    $(".datepicker").dateMask({separator:'/', format:'dmy', minYear:1900, maxYear:2030});
    $(".datepicker").datepicker($.datepicker.regional['es']);



    jQuery(function() {
        $(".money").maskMoney({thousands:',', decimal:'.'});

        $('.money').each(function() {
            if ($(this).val() == "0.00") {
                $(this).val("");
            }

            if ($(this).val().length > 0) {
                $(this).mask();
            }
        });
    });


    $(document).ready(function() {
        $("a.trigger").click(function() {
            $("div.toggle_container").slideToggle("slow");
            return false; //Prevent the browser jump to the link anchor
        });
    });

    $(document).ready(function() {
        $("a.toggle_div").click(function() {
            if ($(this).text() == '(-) ' + this.getAttribute("data-link_text") )
                $(this).text('(+) ' + this.getAttribute("data-link_text"));
            else
              if($(this).text() == '(+) ' + this.getAttribute("data-link_text") )
                $(this).text('(-) ' + this.getAttribute("data-link_text"));

            $("#" + this.getAttribute("data-div_to_toggle")).slideToggle("slow");
            return false; //Prevent the browser jump to the link anchor
        });
    });

    $(document).ready(function() {
        $("a.toggle_tr").click(function() {
            if ($(this).text() == '(-) ' + this.getAttribute("data-link_text") )
                $(this).text('(+) ' + this.getAttribute("data-link_text"));
            else
                $(this).text('(-) ' + this.getAttribute("data-link_text"));

            $("tr." + this.getAttribute("data-class_tr_to_toggle")).toggle();
            return false; //Prevent the browser jump to the link anchor
        });
    });


    jQuery(document).ready(function($) {
        $('a[rel*=facebox]').facebox()
    })


    jQuery(document).ready(function($) {
        $(".multi_select_filter")
                .multiselect({
                                 selectedText: "# de # listados",
                                 noneSelectedText: '',
                                 selectedList: 1000
                             })
                .multiselectfilter();
    });

    jQuery(document).ready(function($) {
        $(".multi_select_no_filter")
                .multiselect({
                                 selectedText: "# de # listados",
                                 noneSelectedText: '',
                                 selectedList: 4
                             })
    });

    jQuery(document).ready(function($) {
        $(".one_select_filter")
                .multiselect({
                                 selectedList: 1,
                                 noneSelectedText: '',
                                 multiple: false
                             })
                .multiselectfilter();
    });

    $(document).ready(function() {
        $(".plus_chart").button({icons: {primary:'ui-icon-plus'}});
        $(".one_to_one_chart").button({icons: {primary:'ui-icon-arrow-4-diag'}});
        $(".minus_chart").button({icons: {primary:'ui-icon-minus'}});
    });




}



/*
 $(document).bind('afterClose.facebox', function() {
 var h = document.getElementById("myhidden").value;
 document.getElementById("firstHidden").value = h;
 })
 */



//funcion para serializar los forms del filtro y del select del paginador
function mergeForms(trigger_form) {
    var forms = [];
    forms[0] = document.getElementById(trigger_form);
    forms[1] = document.forms["filter_form"];
    var targetForm = forms[0];
    $.each(forms, function(i, f) {
        if (i != 0) {
            $(f).find('input, select, textarea')
                    .hide()
                    .appendTo($(targetForm));
        }
    });
    $(targetForm).submit();
}




function toggle_index_child(id) {
    $('#' + id).slideToggle("slow");
    //return false; lo tuve que poner en la llamada a esta funcion, sino el bnavegador iba al anchor igualmente
}

// en el form de Project, cuando se elije una moneda se abilita el LifeCycle, sino no se muestra la moneda en los forms de phases_joins
function enable_disable_life_cycle(currency){
    if (currency.value.length > 0){
        $('#project_life_cycle_id').attr('disabled', false);
    }
    else{
        $('#project_life_cycle_id').attr('disabled', true);
    }
}

//en el form de Project, si se elije un LifeCycle se desabilita el currency, para que no haya inconsistencia en los forms de PhaseJoins
//no esta habilitado ahora porque esta mal hecho
function enable_disable_currency(life_cycle){
    if (life_cycle.value.length > 0){
        $('#project_currency').attr('disabled', true);
    }
    else{
        $('#project_currency').attr('disabled', false);
    }
}




// ##############  PRUEBAS ###############

$(function($) {
    $("#xx").change(function() {
        $.ajax({url: '/ajaxtests/fill_phases',
            data: 'ajaxtest[life_cycle_id]=' + this.value + '&message=' + this.getAttribute("data-message"),
            dataType: 'script'})
    });
});




/*
 jQuery(function($) {
 $("#projects_users_join_user_id").wrap('<div id="users_select" style="float:left" />');
 });

 jQuery(function($) {
 // when the #projects_users_join_project field changes
 $("#projects_users_join_project_id").change(function() {
 // make a POST call and replace the content
 var project = $('select#projects_users_join_project_id :selected').val();
 if(project == "") project="0";
 jQuery.get('/projects_users_joins/update_user_select/' + project, function(data){
 $("#users_select").html(data);
 })
 return false;
 });

 });*/
