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

		$this->addScript('menu', '/resources/js/all.js');
		// $this->addScript('collapsable', '/resources/js/collapsable.js');
		// $this->addScript('search', '/resources/js/search.js');
		// $this->addScript('collapsible', '/resources/collapsible/bulma-collapsible.min.js');

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

		HookRegistry::register ('TemplateManager::display', array($this, 'loadAdditionalData'));
		
	}

	public function loadAdditionalData($hookName, $args) {
		$smarty = $args[0];

		$request = $this->getRequest();
		$context = $request->getContext();

		if (!defined('SESSION_DISABLE_INIT')) {

			// Get possible locales
			if ($context) {
				$locales = $context->getSupportedLocaleNames();
			} else {
				$locales = $request->getSite()->getSupportedLocaleNames();
			}

			// $orcidImageUrl = $this->getPluginPath() . '/' . ORCID_IMAGE_URL;

			$smarty->assign(array(
				'languageToggleLocales' => $locales,
				// 'orcidImageUrl' =>  $orcidImageUrl,
			));
		}
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
