if Meteor.isClient

	@state = {}
	grouped = _.groupBy data, \type

	for i in (_.keys grouped)
		nums = (name) -> grouped[i]map -> it[name]
		range = (name) -> "#name":
			max: _.max nums name
			min: _.min nums name
			avg: -> ((this.max - this.min) / 2) + this.min
		state[i] = _.merge ... <[ rooms area ]>map -> range it

	guessType = (obj) ->
		arr = _.keys(grouped)map (i) -> name: i, value: do ->
			delta = (name) -> state[i][name]avg! - obj[name]
			range = (name) -> state[i][name]max - state[i][name]min
			[rooms, area] = <[ rooms area ]>map (i) ->
				(delta i) / (range i)
			Math.sqrt (Math.pow rooms, 2) + (Math.pow area, 2)
		arr.sort (a, b) -> a.value - b.value

	console.log guessType rooms: 4, area: 400
