{**
 * templates/content.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * Display Static Page content
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$title}

<div class="page">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey=$title}
	<h1>
		{$title|escape}
	</h1>

	{$content}
</div>

{include file="frontend/components/footer.tpl"}