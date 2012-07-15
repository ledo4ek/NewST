<?php
/**
 * Active record with Materialized path implementation
 *
 * @property string $path
 */
class LbMatpathRecord extends CActiveRecord
{
	protected $_nodeIdField = 'id';
	
	/**
	 * @param string $className
	 * @return LbMatpathRecord
	 */
    public static function model($className=__CLASS__)
    {
        return parent::model($className);
    }

    /**
     * Return children nodes
     * @param mixed $condition
     * @param array $params
     * @return LbMatpathRecord[]
     */
    public function getChildren($condition = '', $params = array())
    {
		$criteria = $this->getCommandBuilder()->createCriteria($condition, $params);
		$criteria->addCondition('path=:path')
			->params[':path'] = $this->getPath();
		return $this->findAll($criteria);	
    }

	/**
	 * @param string $condition
	 * @param array $params
	 * @param bool $withSelf
	 * @return LbMatpathRecord[]
	 */
	public function getDescendants($condition = '', $params = array(), $withSelf = false)
	{
		$criteria = $this->getCommandBuilder()->createCriteria($condition, $params);
		$criteria->addCondition('path LIKE :path')
			->params[':path'] = $this->getPath() . '%';
		$descendants = $this->findAll($criteria);
		if ($withSelf) {
			array_unshift($descendants, $this);
		}
		return $descendants;
	}

	/**
	 * @param mixed $condition
	 * @param array $params
	 * @param bool $includeSelf
	 * @return LbMatpathRecord[]
	 */
    public function getParents($condition = '', $params = array(), $includeSelf = false)
    {
		$criteria = $this->getCommandBuilder()->createCriteria($condition, $params);
		
		$pieces = explode('/', $this->path);
		if ($includeSelf) {
			$pieces[] = $this->getNodeField();
		}
		$path = '';
		$cnt = 0;

		foreach ($pieces as $k => $val) {
			if (!$val) unset($pieces[$k]);
		}

		if (!$pieces) {
			return array();
		}

		while ($nodeId = array_shift($pieces)) {
			$criteria->addCondition('path=:p' . $cnt . " AND {$this->_nodeIdField}=:p" . ($cnt+1), 'OR');
			$criteria->params[':p' . $cnt] = $path;
			$criteria->params[':p' . ($cnt+1)] = $nodeId;

			$path = $path ? "$path/$nodeId" : $nodeId;
			$cnt += 2;
		}

		return $this->findAll($criteria);
    }

	/**
	 * @param mixed $condition
	 * @param array $params
	 * @return LbMatpathRecord
	 */
	public function getParent($condition = '', $params = array())
	{
		$paths = explode('/', $this->path);
		
		$criteria = $this->getCommandBuilder()->createCriteria($condition, $params);
		$criteria->addCondition("path=:path AND {$this->_nodeIdField}=:nodeId");
		$criteria->params[':nodeId'] = array_pop($paths);
		$criteria->params[':path'] = implode('/', $paths);

		return $this->find($criteria);
	}

    /**
     * @param mixed $condition
     * @param array $params
     * @return array
     */
    public function getSiblings($condition = '', $params = array())
    {
		$criteria = $this->getCommandBuilder()->createCriteria($condition, $params);
		$criteria->addCondition('path=:path')
			->params[':path'] = $this->path;
		return $this->findAll($criteria);	
    }

	/**
	 * Return the full path of node
	 * @return string
	 */
    public function getPath()
    {
    	return (string)($this->path ? $this->path . '/' . $this->getNodeField() : $this->getNodeField());
    }

	/**
	 * Return the hierarchy level of node
	 * @return int
	 */
	public function getLevel()
	{
		if (!$this->path) {
			return 0;
		} else if (strpos($this->path, '/') === false) {
			return 1;
		} else {
			return substr_count($this->path, '/') + 1;
		}
	}

	/**
	 * Find the node by its path
	 * @param string|array $path
	 * @return LbMatpathRecord
	 */
    public function findByPath($path, $condition = '', $params = array())
    {
		if (!$path) {
			$path = '';
		}
    	if ($path[0] == '/') {
    		$path = substr($path, 1);
    	}
    	$pathPieces = explode('/', $path);

		$criteria = new CDbCriteria();
		$criteria->limit = 1;    	
    	
    	$path = '';
    	$sql = '';
    	while ($nodeId = array_shift($pathPieces)) {
    		if ($sql) {
    			$sql .= ' OR ';
    		}
			$sql .= '(path=' . self::$db->quoteValue($path) . ' AND ' . $this->_nodeIdField . '=' . self::$db->quoteValue($nodeId) .')';
			$path .= $path ? "/$nodeId" : $nodeId;
		}
		$criteria->condition = $sql;
		$criteria->mergeWith($this->getCommandBuilder()->createCriteria($condition, $params));
		
		return $this->find($criteria);
    }

	public function getNodeField()
	{
		return $this->{$this->_nodeIdField};
	}

	/**
	 * Create the child instance
	 * @param string $scenario
	 * @return LbMatpathRecord
	 */
	public function createChild($scenario = 'insert')
	{
		$className = get_class($this);
		/** @var LbMatpathRecord $child  */
		$child = new $className($scenario);
		$child->path = $this->getPath();
		return $child;
	}

	public function hasDescendantWithPath($path)
	{
		return substr($path, $this->getPath()) !== false;
	}

	public function findRootNode()
	{
		return $this->find('path=""');
	}
}