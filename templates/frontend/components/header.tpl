{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if !$displayPageHeaderLogo}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!doctype html>
<html data-theme="ligth" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
	{if !$pageTitleTranslated}
		{capture assign="pageTitleTranslated"}
			{translate key=$pageTitle}
		{/capture}
	{/if}
	{include file="frontend/components/headerHead.tpl"}

	<body
		class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}"
		dir="{$currentLocaleLangDir|escape|default:"ltr"}">

		<div class="pkp_structure_page">


			{* Header *}
			<header class="pkp_structure_head" id="headerNavigationContainer" role="banner">
				{* Skip to content nav links *}
				{include file="frontend/components/skipLinks.tpl"}

				{if !$requestedPage || $requestedPage === 'index'}
					<h1 class="pkp_screen_reader">
						{if $currentContext}
							{$displayPageHeaderTitle|escape}
						{else}
							{$siteTitle|escape}
						{/if}
					</h1>
				{/if}

				<nav class="pkp_head_wrapper navbar is-primary" role="navigation" aria-label="main navigation">
					<div class="container">
						<div class="pkp_site_name_wrapper navbar-brand">
							<div class="pkp_site_name navbar-item">
								{capture assign="homeUrl"}
									{url page="index" router=$smarty.const.ROUTE_PAGE}
								{/capture}
								{if $displayPageHeaderLogo}
									<a href="{$homeUrl}" class="is_img">
										<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
											width="{$displayPageHeaderLogo.width|escape}"
											height="{$displayPageHeaderLogo.height|escape}"
											{if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
											{/if} />
									</a>
								{elseif $displayPageHeaderTitle}
									<a href="{$homeUrl}" class="is_text">{$displayPageHeaderTitle|escape}</a>
								{else}
									<a href="{$homeUrl}" class="is_img">
										<img src="{$baseUrl}/templates/images/structure/logo.png"
											alt="{$applicationName|escape}" title="{$applicationName|escape}" width="180"
											height="90" />
									</a>
								{/if}
							</div>
							{* <button class="pkp_site_nav_toggle">
							<span>Open Menu</span>
						</button> *}
							<a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false"
								data-target="navbarOJS">
								<span aria-hidden="true"></span>
								<span aria-hidden="true"></span>
								<span aria-hidden="true"></span>
								<span aria-hidden="true"></span>
							</a>

						</div>

						{capture assign="primaryMenu"}
							{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
						{/capture}

						<div id="navbarOJS" class="pkp_site_nav_menu navbar-menu"
							aria-label="{translate|escape key="common.navigation.site"}">
							<a id="siteNav"></a>
							<div class="pkp_navigation_primary_row navbar-start">
								{* Primary navigation menu for current application *}
								{$primaryMenu}
							</div>

							<div class="pkp_navigation_user_wrapper navbar-end" id="navigationUserWrapper">


								{* Search form *}
								{if $currentContext && $requestedPage !== 'search'}
									{* <div class="pkp_navigation_search_wrapper navbar-item"> *}
									<a href="{url page="search"}"
										class="navbar-item icon-text pkp_search pkp_search_desktop">
										<span class="icon"><i class="fas fa-search" aria-hidden="true"></i></span>
										<span aria-hidden="true"> {translate key="common.search"}</span>
									</a>
									{* </div> *}
								{/if}

								{include file="frontend/components/langSwitcher.tpl"}

								<div class="navbar-item has-dropdown is-hoverable">
									<a class="navbar-link">
										<span class="icon"><i class="fas fa-user" aria-hidden="true"></i></span>
									</a>

									<div class="navbar-dropdown is-right">
										{load_menu name="user" id="navigationUser" isRightClass="is-right"  ulClass="is-right" liClass="profile navbar-item"}
									</div>
								</div>


								{* <div class="navbar-item has-dropdown is-active">
									<a class="navbar-link">
										<span class="icon-text has-text-info">
											<span class="icon">
												<i class="fas fa-user"></i>
											</span>
											<span>Info</span>
										</span>
									</a>
									<div class="navbar-dropdown is-right">
										{load_menu name="user" id="navigationUser" isRightClass="is-right"  ulClass="pkp_navigation_user" liClass="profile navbar-item"}
									</div>
								</div> *}

							</div>
						</div>
					</div>
				</nav><!-- .pkp_head_wrapper -->
			</header><!-- .pkp_structure_head -->
			{if $requestedPage == 'index'  || $requestedPage == ''}

				<div class="hero is-primary">
					{call_hook name="Templates::Index::journal"}

					<div class="hero-body container  " >
						{if !$activeTheme->getOption('useHomepageImageAsHeader') && $homepageImage}
							<div class="homepage_image container has-text-centered">
								<p class="title">
									{$displayPageHeaderTitle|escape}</a>
								</p>
								{* <img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" {if $homepageImage.altText}
					alt="{$homepageImage.altText|escape}" {/if}> *}
							</div>
						{/if}

						{* Journal Description *}
						{if $activeTheme->getOption('showDescriptionInJournalIndex')}
							<div class="homepage_about">
								<a id="homepageAbout"></a>
								{* <h2>{translate key="about.aboutContext"}</h2> *}
								{$currentContext->getLocalizedData('description')}
							</div>
						{/if}
					</div>

					<div class="hero-foot">

					</div>

				</div>


			{{/if}}
			{* Wrapper for page content and sidebars *}
			{if $isFullWidth}
				{assign var=hasSidebar value=0}
			{/if}
			<div class="columns container is ancestor">
			<div class="column is-two-thirds pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
				<div class="pkp_structure_main " role="main">
<a id="pkp_content_main"></a>