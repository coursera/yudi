_ = require 'lodash'
Yudi = require '../'

module.exports = (overrides) ->
  _.extend({}, {
    # debug: true
    compileDebug: true
    pretty: true
    compiler: Yudi
    attrs: [
      'data-default-message'
      'data-inflight-message'
      'data-success-message'
      'data-form-error'
      'data-form-correct'
      'data-tooltip'
      'placeholder'
    ]
  }, overrides)
