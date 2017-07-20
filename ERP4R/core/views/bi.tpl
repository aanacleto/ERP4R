<!DOCTYPE html>
<html manifest="/static/main.manifest" lang="pt-PT">
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta charset="UTF-8">
	<title>{title}</title>
	<link rel="shortcut icon" href="/static/logos/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="/static/css/green.css"/> 
	<script type="text/javascript" src="/static/js/prototype.js"></script>
	<script type="text/javascript" src="/static/js/scriptaculous/scriptaculous.js"></script>
	<script type="text/javascript">
	</script>
	</head>
	<body>
		<header>
			<div id="logo"><img src="/static/logos/logo.png"/></div>
		</header>
		{form}
		
		
		<div class="container">

<h1>Browse Dimensions</h1>

<!-- List dimensions from the model -->

<div class="btn-group">
    {% for dimension in dimensions %}
        <button class="btn">
        <a href="{{dimension.name}}">{{dimension.label or dimension.name}}</a>
        </button>
    {% endfor %}
</div>

{% if dimension %}
<h1>Dimension: {{dimension.label or dimension.name}}</h1>

<div>
    <ul class="breadcrumb">

    <!-- Link to the very top of browsed hierarchy:
    
    cell.rollup_dim(dimension, None).to_str()
    
    cell - currently browsed cell
    cell.rollup_dim(dimension, None) - get to the very top
    .to_str() - convert the cell into a string that can be used in URL
    
    see cubes.browser.cuts_to_string() fro more information about the 
    conversion
    -->

    <li><a href="?cut={{cell.rollup_dim(dimension, None).to_str()}}">All</a></li>

    {% if levels %}<span class="divider">::</span>{% endif %}

    {% for level in levels %} 
        <li>
        {% if loop.last %}
            {{level.label}}: {{details[loop.index0]._label}}
        {% else %}
        
        <!-- 
        Create a link to upper levels. The link construction is similar as
        above for the root, just `level` is passed to state concrete
        level to be rolled up to.
        -->
        
        <a href="?cut={{cell.rollup_dim(dimension,level).to_str()}}">
            {{level.label}}: {{details[loop.index0]._label}} 
        </a> 
        <span class="divider">::</span>
        {% endif %}
         </li>
    {% endfor %}
    </ul>
</div>

<!-- Display the data -->

<table class="table table-striped table-bordered">
    <thead>
    <tr><th>{{next_level.label or next_level.name}}</th><th>Count</th><th>Amount</th></tr>
    </thead>
    <tbody>
    {% for row in result.table_rows(dimension) %}
    <tr>
        <td>
        {% if is_last %}
            {{row.label}}
        {% else %}
        <a href="?cut={{cell.drilldown(dimension, row.key)}}">
            {{row.label}}
        </a>
        {% endif %}
        </td>
        <td>{{row.record.record_count}}</td>
        <td>{{row.record.amount_sum}}</td>
    </tr>
    {% endfor %}
    <tr><th>Total</th>
        <th>{{result.summary.record_count}}</th>
        <th>{{result.summary.amount_sum}}</th></tr>
        
    </tbody>
</table>

{% endif %} <!-- if dim -->
</div>
		
		
		
		<footer>
			Powered By: ERP+ @2013
		</footer>
	</body>
</html>
