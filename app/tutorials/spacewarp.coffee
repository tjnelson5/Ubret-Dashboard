Step = zootorial.Step

module.exports = new zootorial.Tutorial
  id: "spacewarp_dashboard_tutorial"
  firstStep: 'welcome'
  steps:
    welcome: new Step
              header: 'Welcome'
              details: "Let's learn about the SpaceWarps Dashboard."
              nextButton: 'Start Tutorial'
              next: 'data1'
    data1: new Step
              header: 'Import Data'
              details: "Before Dashboard can be used we must import data.  Let's import a collection from Talk.  Click 'Data'."
              attachment: 'left center a[data-drawer="data"] 2.0 .5'
              className: 'arrow-left'
              next:
                'click li a[data-drawer="data"]': 'data2'
    data2: new Step
              header: 'Zooniverse Data'
              details: 'Select "Zooniverse" as the data source.'
              attachment: 'left center a[data-tool="Zooniverse"] 1.0 1.5'
              className: 'arrow-left'
              next:
                'click a[data-tool="Zooniverse"]': 'data3'
    data3: new Step
              header: 'Recents, Favourites, and Talk Collections'
              details: "You can import data from Recents, Favourites, or any Talk collection. Click 'Collections' to import from Talk."
              attachment: 'center center .tool-window > .sources center 0.5'
              className: 'arrow-top'
              next:
                'click a[data-target="collections"]': 'data4'
    data4: new Step
              header: 'Talk Collection'
              details: 'Now select the "My Dashboard"" collection.'
              attachment: 'right center .collections > label left center'
              className: 'arrow-right'
              next:
                'change select.user-collection': 'data5'
    data5: new Step
              header: 'Import'
              details: 'And select "Import".'
              attachment: 'right center button.import left center'
              className: 'arrow-right'
              next:
                'click button.import': 'tool'
    tool: new Step
              header: 'Tool'
              details: "Great! Now let's connect some tools.  Click 'Tools'."
              attachment: 'left center a[data-drawer="tool"] 2.0 .5'
              className: 'arrow-left'
              next:
                'click li a[data-drawer="tool"]': 'swviewer1'
    swviewer1: new Step
              header: 'Space Warps Viewer'
              details: 'Click "SpacewarpViewer" to initialize a Space Warp Viewer.'
              attachment: 'left center a[data-tool="SpacewarpViewer"] 1.0 1.6'
              next:
                'click a[data-tool="SpacewarpViewer"]': 'swviewer2'
    swviewer2: new Step
              header: 'Space Warps Viewer'
              details: 'This tool is used for viewing raw astronomical images from Space Warps.  You can help unveil gravitational lenses using this tool!  First connect a data source by selecting "Zooniverse" from "Select Tool".'
              attachment: 'center center .SpacewarpViewer center center'
              next:
                'change select.sources': true
              
    viewer: new Step
              header: "Space Warps Viewer"
              details: "The Space Warps viewer is used to examine raw astronomical images. Right of the image are various tools to expose different features in the image."
              next: 'alpha'
    alpha: new Step
              header: "Parameters (alpha)"
              details: "Adjust this slider to raise or lower the overall brightness of the image."
              attachment: 'right center input[name="alpha"] -0.2 0.30'
              className: 'arrow-right'
              next: 'Q'
    Q: new Step
              header: "Parameters (Q)"
              details: "Adjust this slider to raise or lower only the saturated objects such as bright stars."
              attachment: 'right center input[name="Q"] -0.2 0.30'
              className: 'arrow-right'
              next: 'rgb'
    rgb: new Step
              header: "Parameters (RGB)"
              details: "Adjust these sliders to adjust the red, green, and blue channels."
              attachment: 'right center input.green -0.2 0.30'
              className: 'arrow-right'
