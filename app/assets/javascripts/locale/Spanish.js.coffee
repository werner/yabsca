Ext.onReady ->
  Ext.define "Ext.locale.es.view.organization.Form",
    override: "YABSCA.view.organization.Form"
    name: 'Nombre'
    vision: 'Visión'
    goal: 'Misión'
    description: 'Descripción'

  Ext.define "Ext.locale.es.view.session.Form",
    override: "YABSCA.view.session.Form"
    login: 'Usuario'
    password: 'Contraseña'
    login_button: 'Entrar'

  Ext.define "Ext.locale.es.view.Viewport",
    override: "YABSCA.view.Viewport"
    lang_title: 'Aplicación de Balanced Scorecard'
    lang_settings: 'Opciones'
    lang_units: 'Unidades'
    lang_resp: 'Responsables'
    lang_users: 'Usuarios'
    lang_log_out: 'Salir'
    lang_org_strat: 'Organizaciones y Estrategias'
    lang_persp_obj: 'Perspectivas y Objetivos'
    lang_initiative: 'Iniciativas'
    lang_measure: 'Indicadores'
    lang_target: 'Metas'

  Ext.define "Ext.locale.es.view.initiative.Form",
    override: "YABSCA.view.initiative.Form"
    title: 'Iniciativas'
    save: 'Guardar'
    close: 'Cerrar'
    code: 'Código'
    name: 'Nombre'
    completed: '% Completado'
    beginning: 'Comienzo'
    end: 'Fin'

  Ext.define "Ext.locale.es.view.initiative.Gantt",
    override: "YABSCA.view.initiative.Gantt"
    close: 'Cerrar'

  Ext.define "Ext.locale.es.view.initiative.Menu",
    override: "YABSCA.view.initiative.Menu"
    new: 'Nuevo'
    edit: 'Editar'
    delete: 'Eliminar'

  Ext.define "Ext.locale.es.view.measure.Chart",
    override: "YABSCA.view.measure.Chart"
    title: 'Gráfico'
    close: 'Cerrar'
    title_achieved: 'Real'
    title_period: 'Periodo'
