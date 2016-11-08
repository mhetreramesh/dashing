class Dashing.Linechart extends Dashing.Chartjs
  ready: ->
    users_count = @get('users_count')
    months=[]
    counts = []
    for month_count in users_count.data
      if month_count.createdMonth isnt '1970-01'
        months.push month_count.displayMonth
        counts.push month_count.users

    @lineChart 'myChart', # The ID of your html element
      months, # Horizontal labels
      [
        label: 'Number of pushups' # Text displayed when hovered
        colorName: 'green' # Color of data
        data: counts # Vertical points
      ]
