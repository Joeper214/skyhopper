/// <reference path="../../declares.d.ts" />

export default Vue.extend({
  template: '#resource-panel-template',
  el: () => { return document.createElement('div'); },
  props: {
    desc: {
      type: Object,
      twoWay: true,
      required: true,
    },
    idx: {
      type: Number,
      required: true,
    },
  },
  methods: {
    addIt: function () {
      this.desc.body.push({
        type: 'it',
        should: true,
        matcher: {name: 'be_', args: [], chains: []},
      });
    },

    addIts: function () {
      this.desc.body.push({
        type: 'its',
        name: "",
        should: true,
        matcher: {name: 'be_', args: [], chains: []},
      });
    },

    removeIt: function(idx: number) {
      this.desc.body.$remove(idx);
    },

    accordionToggle: function () {
      const el = (<HTMLElement>this.$el).querySelector('.collapse');
      $(el).collapse('toggle');
      const up = (<HTMLElement>this.$el).querySelector('.glyphicon-chevron-up');
      const down = (<HTMLElement>this.$el).querySelector('.glyphicon-chevron-down');
      $(up).removeClass("glyphicon-chevron-up");
      $(down).removeClass("glyphicon-chevron-down");
      $(up).addClass("glyphicon-chevron-down");
      $(down).addClass("glyphicon-chevron-up");
    },
  },
  ready: function() {
    console.log(this);
  }
});
