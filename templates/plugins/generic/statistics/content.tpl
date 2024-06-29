{**
 * @file plugins/generic/statistics/index.tpl
 *
 * Copyright (c) 2016 Fran Máñez - Universitat Politècnica de Catalunya (UPC)
 * fran.upc@gmail.com
 *
 * Updated for OJS 3.x by: Reewos Talla <reewos.etc@gmail.com>
 *
 *
 *}

{strip}
	{assign var="pageTitle" value="plugins.generic.statistics.name"}
	{include file="frontend/components/header.tpl"}
{/strip}

<head>
	{* <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
	</script> *}
	{* <script src="{$baseUrl}/plugins/generic/statistics/js/bootstrap-switch.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="{$baseUrl}/plugins/generic/statistics/css/bootstrap-statistics.css" type="text/css" />
		<link rel="stylesheet" href="{$baseUrl}/plugins/generic/statistics/css/bootstrap-switch.min.css" type="text/css" />
		<link rel="stylesheet" href="{$baseUrl}/plugins/generic/statistics/css/range.css" type="text/css" /> *}
</head>

<h1>{translate key="plugins.generic.statistics.titlePage"}</h1>
<h2>... bulma...</h2>

<div class="is-flex is-flex-direction-row is-flex-wrap-wrap">
	<div class="m-2 is-flex is-flex-direction-row is-flex-wrap-wrap" id="divSpinner" role="group" aria-label="...">

		{* <span class="tag is-dark is-medium mr-2">{translate key="plugins.themes.bulma.statistics.year"}</span> *}

		<div class="buttons has-addons">
				<button type="button" name="btnPrev" id="btnPrev" class="button is-small">
					<span class="icon is-small"><i class="fas fa-minus" aria-hidden="true"></i></span>
				</button>
				<button type="button" disabled class="button is-small">
					<span class="" name="valueYear" id="year">{'Y'|date}</span>
				</button>
				<button type="button" name="btnNext" id="btnNext" class="button is-small">
					<span class="icon is-small">
						<i class="fas fa-plus" aria-hidden="true"></i>
					</span>
				</button>
		</div>

		{* <button type="button" name="valueYear" id="year" disabled="disabled" class="button">{'Y'|date}</button> *}

	</div>
	{* <span class="tag is-dark is-medium mr-2">{translate key="plugins.themes.bulma.statistics.types"}</span> *}
	<div class="select m-2 is-small">
		<select>
			<option name="typeChart" id="btnTypeColumns" class="dropdown-item">
				{translate key="plugins.generic.statistics.columns"}</option>
			<option name="typeChart" id="btnTypeColumnsStack" class="dropdown-item">
				{translate key="plugins.generic.statistics.columnsStack"}</option>
			<option name="typeChart" id="btnTypeLine" class="dropdown-item">
				{translate key="plugins.generic.statistics.lines"}</option>
		</select>
	</div>
	<div class="select m-2 is-small">
		<select>
			<option class="tab is-active" id="chartMonth">
				{translate key="plugins.generic.statistics.monthly"}
			</option>
			<option class="tab" id="chartYear">
				{translate key="plugins.generic.statistics.lastYears"}
			</option>
			<option class="tab" id="chartWeek">
				{translate key="plugins.generic.statistics.lastDays"}
			</option>
			<option class="tab" id="chartByCountry">
				{translate key="plugins.generic.statistics.byCountry"}
			</option>
			<option class="tab" id="chartArticleDownload">
				{translate key="plugins.generic.statistics.article"}
					({translate key="plugins.generic.statistics.downloads"})
			</option>
			<option class="tab" id="chartArticleAbstract">
				{translate key="plugins.generic.statistics.article"}
					({translate key="common.abstract"})
			</option>
			<option class="tab" id="chartIssues">
				{translate key="plugins.generic.statistics.issues"}
			</option>
		</select>
	</div>


</div>

<div class="box">
<progress id="progressBar" class="progress is-small is-link" max="100">10%</progress>
	<div id="chartPanel"></div>
</div>

{include file="frontend/components/footer.tpl"}


<script language="javascript">
	{literal}

		var l = window.location;
		// '{/literal}{$url}/statistics{literal}';
		console.log(l);

		var base_location = l;
		var base_url = l.protocol + "//" + l.host + "/" + l.pathname.split('/')[1];
		var base_url_journal = l.pathname.slice(0, l.pathname.lastIndexOf('/'));

		var typeChart = "column";
		var tabSelected = "tabMonth";


		$(document).ready(function() {

		$('#chartMonth').on('click', function(e) {
			jQuery.fn.updateChartMonth();
		});
		$('#chartYear').on('click', function(e) {
			jQuery.fn.updateChartByYear();
		});
		$('#chartWeek').on('click', function(e) {
			jQuery.fn.updateChartWeek();
		});
		$('#chartByCountry').on('click', function(e) {
			jQuery.fn.updateChartPaisesAbstract();
		});
		$('#chartArticleDownload').on('click', function(e) {
			jQuery.fn.updateChartPaisesDownload();
		});
		$('#chartArticleAbstract').on('click', function(e) {
			jQuery.fn.updateChartArticleDownload();
		});
		$('#chartIssues').on('click', function(e) {
			jQuery.fn.updateChartIssues();
		});


			/***********************************************************
		 *        			FUNCTIONS UPDATE DATA
		 ***********************************************************/



			//Chart Days 


			//Chart MONTH 
			jQuery.fn.updateChartMonth = function() {
				optionsMonth.title.text = '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal} '+$('#year').text();
				
				$("#progressBar").removeClass('is-hidden');
				jQuery.getJSON(base_location + '/getStatisticsByMonth?year=' + $('#year').text(), null, function(
					data) {

					optionsMonth.series = new Array(data.length);

					for (var i = 0; i < data.length; i++) {
						optionsMonth.series[i] = new Object();
						optionsMonth.series[i].name = data[i].name;
						optionsMonth.series[i].data = data[i].values;
					}
					
					$("#progressBar").addClass('is-hidden');
					$("#chartPanel").html(JSON.stringify(data));
					// chartMonth = new Highcharts.Chart(optionsMonth);
				});
			};


			//Chart YEAR
			jQuery.fn.updateChartByYear = function() {

				$("#progressBar").removeClass('is-hidden');
				$yearSelected = $('#year').text();
				$yearSelected5 = $yearSelected - 5;

				optionsByYear.title.text = '{/literal}{translate key="plugins.generic.statistics.querysFrom"}{literal} '+$yearSelected5+' {/literal}{translate key="plugins.generic.statistics.querysTo"}{literal} '+$yearSelected,
				optionsByYear.xAxis.categories = [$yearSelected - 5, $yearSelected - 4, $yearSelected - 3,
					$yearSelected - 2, $yearSelected - 1, $yearSelected
				];

				jQuery.getJSON(base_location + '/getStatisticsByYear?year=' + $('#year').text(), null, function(
					data) {

					optionsByYear.series = new Array(data.length);

					for (var i = 0; i < data.length; i++) {
						optionsByYear.series[i] = new Object();
						optionsByYear.series[i].name = data[i].name;
						optionsByYear.series[i].data = data[i].values;
					}

					$("#progressBar").addClass('is-hidden');
					$("#chartPanel").html(JSON.stringify(data));
					// chartByYear = new Highcharts.Chart(optionsByYear);
				});
			};

			//Chart WEEK
			jQuery.fn.updateChartWeek = function() {
				optionsWeek.title.text = '{/literal}{translate key="plugins.generic.statistics.forWeek"}{literal}';
				$("#progressBar").removeClass('is-hidden');

				jQuery.getJSON(base_location + '/getStatisticsWeek?year=' + $('#year').text(), null, function(
					data) {

					optionsWeek.series = new Array(data.length);

					for (var i = 0; i < data.length; i++) {
						optionsWeek.series[i] = new Object();
						optionsWeek.series[i].name = data[i].name;
						optionsWeek.series[i].data = data[i].values;
						optionsWeek.series[i].day = data[i].day;
					}
					//data[0].day = date(data[0].day);

					optionsWeek.xAxis.categories = data[0].day;
					$("#progressBar").addClass('is-hidden');
					$("#chartPanel").html(JSON.stringify(data));
					// chartWeek = new Highcharts.Chart(optionsWeek);
				});
			};

			//Chart COUNTRY ABSTRACT
			jQuery.fn.updateChartPaisesAbstract = function() {

				optionsPaisesAbstract.title.text = '{/literal}{translate key="plugins.generic.statistics.viewAbstractsByCountry"}{literal} '+$('#year').text();
				$("#progressBar").removeClass('is-hidden');

				$yearSelected = $('#year').text();

				jQuery.getJSON(base_location + '/getStatisticsByCountryAbstract?year=' + $yearSelected, null,
					function(data) {

						optionsPaisesAbstract.series[0].data = [];

						for (var i = 0; i < data.length; i++) {
							optionsPaisesAbstract.series[0].data[i] = [data[i].country, parseInt(data[i]
								.count)];
						}

						$("#progressBar").addClass('is-hidden');
						$("#chartPanel").html(JSON.stringify(data));
						// chartCountryAbstract = new Highcharts.Chart(optionsPaisesAbstract);
					});
			};

			//Chart COUNTRY DOWNLOAD
			jQuery.fn.updateChartPaisesDownload = function() {

				optionsPaisesDownload.title.text = '{/literal}{translate key="plugins.generic.statistics.viewDownloads"}{literal} '+$('#year').text();

				$yearSelected = $('#year').text();
				$("#progressBar").removeClass('is-hidden');

				jQuery.getJSON(base_location + '/getStatisticsByCountryDownload?year=' + $yearSelected, null,
					function(data) {

						optionsPaisesDownload.series[0].data = [];

						for (var i = 0; i < data.length; i++) {
							optionsPaisesDownload.series[0].data[i] = [data[i].country, parseInt(data[i]
								.count)];
						}

						$("#progressBar").addClass('is-hidden');
						$("#chartPanel").html(JSON.stringify(data));
						// chartCountryDownload = new Highcharts.Chart(optionsPaisesDownload);
					});
			};

			//Chart and list ARTICLE DOWNLOAD
			jQuery.fn.updateChartArticleDownload = function() {
				optionsArticleDownload.title.text = '{/literal}{translate key="plugins.generic.statistics.rankingDownloadArticles"}{literal} '+$('#year').text();

				$yearSelected = $('#year').text();
				$("#progressBar").removeClass('is-hidden');

				jQuery.getJSON(base_location + '/getStatisticsMostPopularDownload?year=' + $yearSelected +
					"&type=515", null,
					function(data) {

						optionsArticleDownload.series[0].data = [];

						$("#tbodyDownload").html('');
						for (var i = 0; i < data.length; i++) {
							optionsArticleDownload.series[0].data[i] = ["#" + (i + 1), parseInt(data[i]
								.count)];

							$("#tbodyDownload").append('<tr>' +
								'<td class="text-center success">' + (i + 1) + '</td>' +
								'<td class="text-left">' +
								'<a href="' + base_url_journal + '/article/view/' + data[i].id +
								'" class="pkpStatistics__itemLink">' + data[i].article + '</a>' +
								'</td>' +
								'<td class="text-center">' + data[i].count + '</td>' +
								'</tr>');
						}

						$("#progressBar").addClass('is-hidden');
						$("#chartPanel").html(JSON.stringify(data));
						// chartArticleDownload = new Highcharts.Chart(optionsArticleDownload);
					});
			};

			//Chart and list ARTICLE ABSTRACT
			jQuery.fn.updateChartArticleAbstract = function() {

				optionsArticleAbstract.title.text = '{/literal}{translate key="plugins.generic.statistics.rankingAbstractArticles"}{literal} '+$('#year').text();

				$yearSelected = $('#year').text();
				$("#progressBar").removeClass('is-hidden');

				jQuery.getJSON(base_location + '/getStatisticsMostPopularDownload?year=' + $yearSelected +
					"&type=1048585", null,
					function(data) {

						optionsArticleAbstract.series[0].data = [];

						$("#tbodyAbstract").html('');
						for (var i = 0; i < data.length; i++) {
							optionsArticleAbstract.series[0].data[i] = ["#" + (i + 1), parseInt(data[i]
								.count)];

							$("#tbodyAbstract").append('<tr>' +
								'<td class="text-center success">' + (i + 1) + '</td>' +
								'<td class="text-left">' +
								'<a href="' + base_url_journal + '/article/view/' + data[i].id + '">' +
								data[i].article + '</a>' +
								'</td>' +
								'<td class="text-center">' + data[i].count + '</td>' +
								'</tr>');
						}

						$("#progressBar").addClass('is-hidden');
						$("#chartPanel").html(JSON.stringify(data));
						// chartArticleAbstract = new Highcharts.Chart(optionsArticleAbstract);
					});
			};

			//Chart and list ISSUES
			jQuery.fn.updateChartIssues = function() {

				optionsIssues.title.text = '{/literal}{translate key="plugins.generic.statistics.rankingIssues"}{literal} '+$('#year').text();

				$yearSelected = $('#year').text();
				$("#progressBar").removeClass('is-hidden');

				jQuery.getJSON(base_location + '/getStatisticsIssues?year=' + $yearSelected, null, function(data) {

					optionsIssues.series[0].data = [];

					$("#tbodyIssues").html('');
					for (var i = 0; i < data.length; i++) {
						optionsIssues.series[0].data[i] = ["Vol. " + data[i].volume + ", Num. " + data[i]
							.number + ", Year " + data[i].year, parseInt(data[i].count)
						];

						$("#tbodyIssues").append('<tr>' +
							'<td class="text-center success">' + (i + 1) + '</td>' +
							'<td class="text-center">' + data[i].volume + '</td>' +
							'<td class="text-center">' + data[i].number + '</td>' +
							'<td class="text-center">' + data[i].year + '</td>' +
							'<td class="text-left">' + data[i].name + '</td>' +
							'<td class="text-center">' + data[i].count + '</td>' +
							'</tr>');
					}

					$("#progressBar").addClass('is-hidden');
					$("#chartPanel").html(JSON.stringify(data));
					// chartIssues = new Highcharts.Chart(optionsIssues);
				});
			};


			/***********************************************************
		 *           			 CHARTS
		 ***********************************************************/

			//Chart Statistics month
			var chartMonth;
			var optionsMonth = {
				chart: {
					renderTo: 'chartStatMonth',
					type: typeChart,
					options3d: {
						enabled: false,
						alpha: 10,
						beta: 25,
						depth: 70
					}
				},
				title: {
					text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text()
				},
				subtitle: {
					text: '{/literal}{translate key="plugins.generic.statistics.byMonth"}{literal}'
				},
				xAxis: {
					categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov',
						'Dec'
					],
					crosshair: true
				},
				yAxis: {
					min: 0,
					title: {
						text: '{/literal}{translate key="plugins.generic.statistics.queryNumbers"}{literal}'
					}
				},
				tooltip: {
					headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
					pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					'<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
					footerFormat: '</table>',
					shared: true,
					useHTML: true
				},
				plotOptions: {
					column: {
						pointPadding: 0.2,
						borderWidth: 0
					}
				},
				series: [],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}

			//onload page load chart by MONTH
			jQuery.fn.updateChartMonth();


			//*******************************************************************************************

		//Chart statistics year
		var chartByYear;
		var optionsByYear = {
			chart: {
				renderTo: 'chartStatByYear',
				type: typeChart,
				options3d: {
					enabled: false,
					alpha: 10,
					beta: 25,
					depth: 70
				}
			},
			title: {
				text: ''
			},
			subtitle: {
				text: '{/literal}{translate key="plugins.generic.statistics.lastYears2"}{literal}'
				},
				xAxis: {
					categories: [],
					crosshair: true
				},
				yAxis: {
					min: 0,
					title: {
						text: '{/literal}{translate key="plugins.generic.statistics.queryNumbers"}{literal}'
					}
				},
				tooltip: {
					headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
					pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					'<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
					footerFormat: '</table>',
					shared: true,
					useHTML: true
				},
				plotOptions: {
					column: {
						pointPadding: 0.2,
						borderWidth: 0
					}
				},
				series: [],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}


			//*******************************************************************************************

		//Chart statistics week
		var chartWeek;
		var optionsWeek = {
			chart: {
				renderTo: 'chartStatWeek',
				type: typeChart,
				options3d: {
					enabled: false,
					alpha: 10,
					beta: 25,
					depth: 70
				}
			},
			title: {
				text: ''
			},
			subtitle: {
				text: '{/literal}{translate key="plugins.generic.statistics.lastDays2"}{literal}'
				},
				xAxis: {
					categories: [],
					crosshair: true
				},
				yAxis: {
					min: 0,
					title: {
						text: '{/literal}{translate key="plugins.generic.statistics.queryNumbers"}{literal}'
					}
				},
				tooltip: {
					headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
					pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					'<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
					footerFormat: '</table>',
					shared: true,
					useHTML: true
				},
				plotOptions: {
					column: {
						pointPadding: 0.2,
						borderWidth: 0
					}
				},
				series: [],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}


			//*******************************************************************************************

		var chartCountryAbstract;

		var optionsPaisesAbstract = {
			chart: {
				renderTo: 'chartCountryAbstract',
				options3d: {
					enabled: true,
					alpha: 45,
					beta: 0
				}
			},
			title: {
				text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
				},
				tooltip: {
					pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
				},
				plotOptions: {
					pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						depth: 35,
						dataLabels: {
							enabled: true,
							format: '{point.name} : {point.y}'
						}
					}
				},
				series: [{
					type: 'pie',
					name: '{/literal}{translate key="plugins.generic.statistics.viewByCountries"}{literal}',
					data: []
				}],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}


			//*******************************************************************************************

		var chartCountryDownload;

		var optionsPaisesDownload = {
			chart: {
				renderTo: 'chartCountryDownload',
				options3d: {
					enabled: true,
					alpha: 45,
					beta: 0
				}
			},
			title: {
				text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
				},
				tooltip: {
					pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
				},
				plotOptions: {
					pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						depth: 35,
						dataLabels: {
							enabled: true,
							format: '{point.name} : {point.y}'
						}
					}
				},
				series: [{
					type: 'pie',
					name: '{/literal}{translate key="plugins.generic.statistics.downloadByCountries"}{literal}',
					data: []
				}],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}


			//*******************************************************************************************

		var chartArticleDownload;

		var optionsArticleDownload = {
			chart: {
				renderTo: 'chartArticleDownload',
				options3d: {
					enabled: true,
					alpha: 45,
					beta: 0
				}
			},
			title: {
				text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
				},
				tooltip: {
					pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
				},
				plotOptions: {
					pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						depth: 35,
						dataLabels: {
							enabled: true,
							format: '{point.name} : {point.y}'
						}
					}
				},
				series: [{
					type: 'pie',
					name: '{/literal}{translate key="plugins.generic.statistics.downloadByCountries"}{literal}',
					data: []
				}],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}

			//*******************************************************************************************

		var chartArticleAbstract;

		var optionsArticleAbstract = {
			chart: {
				renderTo: 'chartArticleAbstract',
				options3d: {
					enabled: true,
					alpha: 45,
					beta: 0
				}
			},
			title: {
				text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
				},
				tooltip: {
					pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
				},
				plotOptions: {
					pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						depth: 35,
						dataLabels: {
							enabled: true,
							format: '{point.name} : {point.y}'
						}
					}
				},
				series: [{
					type: 'pie',
					name: '{/literal}{translate key="plugins.generic.statistics.viewAbstracts"}{literal}',
					data: []
				}],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}

			//*******************************************************************************************

		var chartIssues;

		var optionsIssues = {
			chart: {
				renderTo: 'chartIssues',
				options3d: {
					enabled: true,
					alpha: 45,
					beta: 0
				}
			},
			title: {
				text: '{/literal}{translate key="plugins.generic.statistics.querysToTheJournal"}{literal}'+$('#year').text(),
				},
				tooltip: {
					pointFormat: '{series.name}: <b>{point.y} - {point.percentage:.1f}%</b>'
				},
				plotOptions: {
					pie: {
						allowPointSelect: true,
						cursor: 'pointer',
						depth: 35,
						dataLabels: {
							enabled: true,
							format: '{point.name} : {point.y}'
						}
					}
				},
				series: [{
					type: 'pie',
					name: '{/literal}{translate key="plugins.generic.statistics.viewAbstracts"}{literal}',
					data: []
				}],
				exporting: {
					buttons: {
						contextButton: {
							enabled: false
						}
					}
				}
			}

			/***********************************************************
		 *         			 	EVENTS
		 ***********************************************************/

			$('[data-toggle="tab"]').click(function(e) {
				var $this = $(this);
				href = $this.attr('href');
				if (href == "#tabMonth") {
					tabSelected = "tabMonth";
					if (chartMonth) chartMonth.destroy();
					jQuery.fn.updateChartMonth();

					$('#btnGroup button').removeAttr('disabled');

				} else if (href == "#tabYear") {
					tabSelected = "tabYear";
					if (chartByYear) chartByYear.destroy();
					jQuery.fn.updateChartByYear();

					$('#btnGroup button').removeAttr('disabled');

				} else if (href == "#tabWeek") {
					tabSelected = "tabWeek";
					if (chartWeek) chartWeek.destroy();
					jQuery.fn.updateChartWeek();

					$('#btnGroup button').removeAttr('disabled');

				} else if (href == "#tabByCountry") {
					tabSelected = "tabByCountry";
					if (chartCountryAbstract) chartCountryAbstract.destroy();
					if (chartCountryDownload) chartCountryDownload.destroy();
					jQuery.fn.updateChartPaisesAbstract();
					jQuery.fn.updateChartPaisesDownload();

					$('#btnGroup button').attr('disabled', 'disabled');

				} else if (href == "#tabArticleDownload") {
					tabSelected = "tabArticleDownload";
					if (chartArticleDownload) chartArticleDownload.destroy();
					jQuery.fn.updateChartArticleDownload();

					$('#btnGroup button').attr('disabled', 'disabled');

				} else if (href == "#tabArticleAbstract") {
					tabSelected = "tabArticleAbstract";
					if (chartArticleAbstract) chartArticleAbstract.destroy();
					jQuery.fn.updateChartArticleAbstract();

					$('#btnGroup button').attr('disabled', 'disabled');

				} else if (href == "#tabIssues") {
					tabSelected = "tabIssues";
					if (chartIssues) chartIssues.destroy();
					jQuery.fn.updateChartIssues();

					$('#btnGroup button').attr('disabled', 'disabled');
				}

				$this.tab('show');

				return false;
			});

			$('#btnPrev').on('click', function(e) {
				$('#year').text($('#year').text() - 1);
				if (tabSelected == "tabMonth") {
					$('this').updateChartMonth();
				} else if (tabSelected == "tabYear") {
					$('this').updateChartByYear();
				} else if (tabSelected == "tabByCountry") {
					$('this').updateChartPaisesAbstract();
					$('this').updateChartPaisesDownload();
				} else if (tabSelected == "tabArticleDownload") {
					$('this').updateChartArticleDownload();
				} else if (tabSelected == "tabArticleAbstract") {
					$('this').updateChartArticleAbstract();
				} else if (tabSelected == "tabIssues") {
					$('this').updateChartIssues();
				}
			});

			$('#btnNext').on('click', function(e) {
				$("#year").text($('#year').text() - 0 + 1);
				if (tabSelected == "tabMonth") {
					$('this').updateChartMonth();
				} else if (tabSelected == "tabYear") {
					$('this').updateChartByYear();
				} else if (tabSelected == "tabByCountry") {
					$('this').updateChartPaisesAbstract();
					$('this').updateChartPaisesDownload();
				} else if (tabSelected == "tabArticleDownload") {
					$('this').updateChartArticleDownload();
				} else if (tabSelected == "tabArticleAbstract") {
					$('this').updateChartArticleAbstract();
				} else if (tabSelected == "tabIssues") {
					$('this').updateChartIssues();
				}
			});

			$('#btnTypeColumns').on('click', function(e) {

				$("#btnTypeColumns").attr('class', 'btn btn-success');
				$("#btnTypeColumnsStack").attr('class', 'btn btn-default');
				$("#btnTypeLine").attr('class', 'btn btn-default');

				typeChart = 'column';
				optionsMonth.chart.type = 'column';
				optionsMonth.plotOptions.column.stacking = '';
				optionsByYear.chart.type = 'column';
				optionsByYear.plotOptions.column.stacking = '';
				optionsWeek.chart.type = 'column';
				optionsWeek.plotOptions.column.stacking = '';

				// if (tabSelected == "tabMonth") {
				// 	chartMonth = new Highcharts.Chart(optionsMonth);
				// } else if (tabSelected == "tabYear") {
				// 	chartByYear = new Highcharts.Chart(optionsByYear);
				// } else if (tabSelected == "tabWeek") {
				// 	chartWeek = new Highcharts.Chart(optionsWeek);
				// }
			});

			$('#btnTypeColumnsStack').on('click', function(e) {

				$("#btnTypeColumns").attr('class', 'btn btn-default');
				$("#btnTypeColumnsStack").attr('class', 'btn btn-success');
				$("#btnTypeLine").attr('class', 'btn btn-default');

				typeChart = 'column';
				optionsMonth.chart.type = 'column';
				optionsMonth.plotOptions.column.stacking = 'normal';
				optionsByYear.chart.type = 'column';
				optionsByYear.plotOptions.column.stacking = 'normal';
				optionsWeek.chart.type = 'column';
				optionsWeek.plotOptions.column.stacking = 'normal';

				// if (tabSelected == "tabMonth") {
				// 	chartMonth = new Highcharts.Chart(optionsMonth);
				// } else if (tabSelected == "tabYear") {
				// 	chartByYear = new Highcharts.Chart(optionsByYear);
				// } else if (tabSelected == "tabWeek") {
				// 	chartWeek = new Highcharts.Chart(optionsWeek);
				// }
			});


			$('#btnTypeLine').on('click', function(e) {

				$("#btnTypeColumns").attr('class', 'btn btn-default');
				$("#btnTypeColumnsStack").attr('class', 'btn btn-default');
				$("#btnTypeLine").attr('class', 'btn btn-success');

				typeChart = 'line';
				optionsMonth.chart.type = 'line';
				optionsMonth.plotOptions.column.stacking = '';
				optionsByYear.chart.type = 'line';
				optionsByYear.plotOptions.column.stacking = '';
				optionsWeek.chart.type = 'line';
				optionsWeek.plotOptions.column.stacking = '';

				// if (tabSelected == "tabMonth") {
				// 	chartMonth = new Highcharts.Chart(optionsMonth);
				// } else if (tabSelected == "tabYear") {
				// 	chartByYear = new Highcharts.Chart(optionsByYear);
				// } else if (tabSelected == "tabWeek") {
				// 	chartWeek = new Highcharts.Chart(optionsWeek);
				// }
			});

		}); //end ready function

	{/literal}
</script>
