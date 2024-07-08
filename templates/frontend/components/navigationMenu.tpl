{**
 * templates/frontend/components/navigationMenu.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Primary navigation menu list for the application
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

{if $navigationMenu}
	{if $id == 'navigationPrimary'} 
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
			<div class="{$liClass|escape} navbar-item has-dropdown is-hoverable">
				<a class="navbar-link" href="#">
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				</a>
				<div class="navbar-dropdown {$ulClass|escape}">
					{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
						{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
							{* <li class="{$liClass|escape} navbar-item"> *}
							<a class="navbar-item" href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
								{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
							</a>
							{* </li> *}
						{/if}
					{/foreach}
				</div>
			</div>
		{else}
			{* <li class="{$liClass|escape}"> *}
			<a class="navbar-item" href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
				{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
			</a>
			{* </li> *}
		{/if}
	{/foreach}
	{* </ul> *}
{/if}
{if $id == 'navigationUser'} 
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
				<p  class="menu-label">
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				</p>
				<ul class="menu-list {$ulClass|escape}">
					{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
						{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
							<li class="{$liClass|escape}">
							<a class="navbar-item" href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}">
								{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
							</a>
							</li>
							
						{/if}
					{/foreach}
				</ul>
				<div class="divider is-right m-0"></div>
		{else}
			<li class="{$liClass|escape}">
			<a class="navbar-item" href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}">
				{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
			</a>
			</li>
		{/if}
	{/foreach}
{/if}

{/if}