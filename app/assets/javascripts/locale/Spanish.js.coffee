Ext.onReady ->
  Ext.define "Ext.locale.es.view.organization.Form",
    override: "YABSCA.view.organization.Form"
    name: 'Nombre'
    vision: 'Visión'
    goal: 'Misión'
    description: 'Descripción'
    save: 'Guardar'
    close: 'Cerrar'

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

  Ext.define "Ext.locale.es.view.measure.Form",
    override: "YABSCA.view.measure.Form"
    save: 'Guardar'
    close: 'Cerrar'
    title: 'Indicador'
    code: 'Código'
    name: 'Name'
    description: 'Descripción'
    challenge: 'Desafio'
    excellent: 'Excelente'
    alert: 'Alerta'
    frecuency: 'Frecuencia'
    from: 'Desde'
    to: 'Hasta'
    unit: 'Unidad'
    responsible: 'Responsable'

  Ext.define "Ext.locale.es.view.measure.Formula",
    override: "YABSCA.view.measure.Formula"
    save: 'Guardar'
    close: 'Cerrar'
    formula: 'Formula'
    title: 'Indicador'

  Ext.define "Ext.locale.es.view.measure.Menu",
    override: "YABSCA.view.measure.Menu"
    new: 'Nuevo'
    edit: 'Editar'
    delete: 'Eliminar'
    chart: 'Gráfico'

  Ext.define "Ext.locale.es.view.objective.Form",
    override: "YABSCA.view.objective.Form"
    title: 'Objetivo'
    save: 'Guardar'
    name: 'Nombre'
    close: 'Cerrar'

  Ext.define "Ext.locale.es.view.organization.Menu",
    override: "YABSCA.view.organization.Menu"
    new: 'Nuevo'
    edit: 'Editar'
    delete: 'Eliminar'
    organizations: 'Organizaciones'
    strategies: 'Estrategias'

  Ext.define "Ext.locale.es.view.perspective.Form",
    override: "YABSCA.view.perspective.Form"
    title: 'Perspectiva'
    save: 'Guardar'
    name: 'Nombre'
    close: 'Cerrar'

  Ext.define "Ext.locale.es.view.perspective.Menu",
    override: "YABSCA.view.perspective.Menu"
    new: 'Nuevo'
    edit: 'Editar'
    delete: 'Eliminar'
    perspectives: 'Perspectivas'
    objectives: 'Objetivos'

  Ext.define "Ext.locale.es.view.responsible.Form",
    override: "YABSCA.view.responsible.Form"
    title: 'Responsable'
    save: 'Guardar'
    name: 'Nombre'
    close: 'Cerrar'
    back: 'Atrás'

  Ext.define "Ext.locale.es.view.responsible.Grid",
    override: "YABSCA.view.responsible.Grid"
    lang_add: 'Agregar'
    edit: 'Editar'
    delete: 'Eliminar'
    name: 'Nombre'

  Ext.define "Ext.locale.es.view.responsible.Window",
    override: "YABSCA.view.responsible.Window"
    title: 'Responsables'
    close: 'Cerrar'

  Ext.define "Ext.locale.es.view.strategy.Form",
    override: "YABSCA.view.strategy.Form"
    title: 'Estrategia'
    save: 'Guardar'
    name: 'Nombre'
    description: 'Descripción'
    close: 'Cerrar'

  Ext.define "Ext.locale.es.view.target.Form",
    override: "YABSCA.view.target.Form"
    title: 'Meta'
    save: 'Guardar'
    close: 'Cerrar'
    period: 'Periodo'
    goal: 'Meta'
    achieved: 'Real'
    back: 'Atrás'

  Ext.define "Ext.locale.es.view.target.Grid",
    override: "YABSCA.view.target.Grid"
    lang_add: 'Agregar'
    edit: 'Editar'
    delete: 'Eliminar'
    calculate: 'Calcular'
    period: 'Periodo'
    goal: 'Meta'
    achieved: 'Real'

  Ext.define "Ext.locale.es.view.target.Panel",
    override: "YABSCA.view.target.Panel"
    title: 'Metas'

  Ext.define "Ext.locale.es.view.unit.Form",
    override: "YABSCA.view.unit.Form"
    title: 'Unidad'
    save: 'Guardar'
    name: 'Nombre'
    close: 'Cerrar'
    back: 'Atrás'

  Ext.define "Ext.locale.es.view.unit.Grid",
    override: "YABSCA.view.unit.Grid"
    lang_add: 'Agregar'
    edit: 'Editar'
    delete: 'Eliminar'
    name: 'Nombre'

  Ext.define "Ext.locale.es.view.unit.Window",
    override: "YABSCA.view.unit.Window"
    title: 'Unidades'
    close: 'Cerrar'

  Ext.define "Ext.locale.es.view.user.Form",
    override: "YABSCA.view.user.Form"
    title: 'Usuario'
    save: 'Guardar'
    login: 'Usuario'
    password: 'Contraseña'
    password_confirmation: 'Confirmar Contraseña'
    close: 'Cerrar'
    back: 'Atrás'

  Ext.define "Ext.locale.es.view.user.Grid",
    override: "YABSCA.view.user.Grid"
    lang_add: 'Agregar'
    edit: 'Editar'
    delete: 'Eliminar'
    login: 'Usuario'

  Ext.define "Ext.locale.es.view.user.Window",
    override: "YABSCA.view.user.Window"
    title: 'Usuarios'
    close: 'Cerrar'
