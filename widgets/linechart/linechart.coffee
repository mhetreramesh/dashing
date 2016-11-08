class Dashing.Linechart extends Dashing.Chartjs
  ready: ->
    users_count = @get('users_count')
    months=[]
    counts = []
    for count in users_count.data
      months.push count.displayMonth
      counts.push count.users

    @lineChart 'myChart', # The ID of your html element
      months, # Horizontal labels
      [
        label: 'Number of pushups' # Text displayed when hovered
        colorName: 'green' # Color of data
        data: counts # Vertical points
      ]
