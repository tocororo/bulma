<?php

/**
 * @file plugins/themes/default/BulmaThemePlugin.php
 *
 * Copyright (c) 2024 Rafael Martínez Estévez
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class BulmaThemePlugin
 * @ingroup plugins_themes_bulma
 *
 * @brief Default theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');


class BulmaThemePlugin extends ThemePlugin
{
	/**
	 * Initialize the theme's styles, scripts and hooks. This is only run for
	 * the currently active theme.
	 *
	 * @return null
	 */
	public function init()
	{
		$this->addStyle(
			'bulma', 'resources/main.css'
		);
		$this->addMenuArea(array('primary', 'user'));

		$this->addScript('menu', '/resources/js/menu.js');

		$this->addOption('showDescriptionInJournalIndex', 'FieldOptions', [
			'label' => __('manager.setup.contextSummary'),
				'options' => [
				[
					'value' => true,
					'label' => __('plugins.themes.default.option.showDescriptionInJournalIndex.option'),
				],
			],
			'default' => false,
		]);
		
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName()
	{
		return __('plugins.themes.bulma.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription()
	{
		return __('plugins.themes.bulma.description');
	}
}
