var tests = [];
for (var file in window.__karma__.files) {
  if (/spec\.js$/.test(file)) {
    tests.push(file);
  }
}

requirejs.config({
  baseUrl: '/base/target',

  paths: {
    text: '../lib/requirejs-text/text',
    d3: '../lib/d3/d3',
    ace: '../lib/ace',
    viz: '../lib/viz',
    spec: '../spec'
  },

  shim: {
    d3: {
      exports: 'd3'
    }
  },

  deps: tests,

  callback: window.__karma__.start
});