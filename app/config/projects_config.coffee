Projects =
  galaxy_zoo: 
    name: 'Galaxy Zoo'
    talk: false
    sources: ["Zooniverse", "Sky Server"]
    tools: ["Histogram", "Scatterplot", "Mapper", "Statistics", "SubjectViewer", "Spectra", "Table"],
    defaults: ["Table", "SubjectViewer"]

  spacewarp: 
    name: 'Space Warps'
    talk: true
    sources: ["Zooniverse"]
    tools: [ "SpacewarpViewer"]
    defaults: [ "SpacewarpViewer"]

  serengeti: 
    name: 'Snapshot Serengeti'
    talk: true
    sources: ["Zooniverse"]
    tools: ["Mapper", "Statistics", "SubjectViewer", "Table", "Histogram"]
    defaults: ["SubjectViewer"]

module.exports = Projects
