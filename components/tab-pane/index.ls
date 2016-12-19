defaults =
  tab:
    reset: ".dib"
    style: ".bw2"
    size: ".w3"
    shape: ".ph2"
    behaviour: ".tc"

  activeTab:
    reset: ".dib"
    style: ""
    size: ""
    shape: ".ph2"
    behaviour: ".grow"

  tabPane:
    reset: ".list.mv0.pl0"
    style: ""
    size: ""
    shape: ""
    behaviour: ".tc"

  contentPane:
    style: ""
    size: ""
    shape: ""
    behaviour: ""

  container:
    style: ""
    size: ""
    shape: ""
    behaviour: ""


view = (h) -> ({ tab={}, tabPane={}, contentPane={}, activeTab={}, container={}, initialTabIndex=1 }={}) ->

  Container = (defaults.Container with container)<[size style shape behaviour]> * ""
  TabPane = (defaults.tabPane with tabPane)<[size style shape behaviour reset]> * ""
  Tab = (defaults.tab with tab)<[size style shape behaviour reset]> * ""
  ActiveTab = Tab + (defaults.activeTab with activeTab)<[size style shape behaviour reset]> * ""
  ContentPane = (defaults.contentPane with contentPane)<[size style shape behaviour]> * ""
    
  ( tabs, get-tab-id, set-tab-id, content, attrs={}) ->

    current-tab = 
      if getTabId() then
        tabs.find( ({id}) -> id is getTabId())
      else 
        tabs[0]
    
    current-id = current-tab.id
      
    header-style =
      (t) -> if t.id is current-id then ActiveTab else Tab

    tab = (t, i) ->
      attrs = { tabIndex: i+initialTabIndex, onfocus: -> set-tab-id(t.id); }
      h('li'+header-style(t), attrs, t.content)

    h Container, attrs
      ,h 'ul'+TabPane
        ,tabs.map(tab)
      ,h ContentPane
        ,content(current-tab)

export { view, defaults }
